class Event < ApplicationRecord
  has_one_attached :image
  belongs_to :organizer
  validates :city, :location, :image, :organizer, presence: true
  validates :title, length: {minimum: 5, message: "Минимальное число символов 5"}, presence: true
  validates :link, format: {with: /\Ahttps?:\/\/[www]?[a-zA-Z0-9_-]*[.][a-z]{2,}\z/, message: "Введите корректный url адрес"}
  validates :event_date, presence: true
  validate :image_size, :valid_datetime

  # Validate image size
  #
  def image_size
    if image.attached?
      if image.byte_size > 1000000
        errors.add(:image, "Размер файла превышает 1MB")
      elsif !image.content_type.starts_with?('image/')
        errors.add(:image, "Файл не относится к изображениям")
      end
    end
  end

  # Validate date format
  #
  def valid_datetime
    unless (event_date.methods.include? :strftime)
      errors.add(:event_date, "требуемый формат DD-MM-YYYY hh:mm")
    end
  end

  # Convert to iCalendar
  #
  def to_ics
    event = Icalendar::Event.new
    event.dtstart = self.event_date.strftime("%Y%m%dT%H%M%S")
    event.summary = self.title
    event.description = self.description
    event.location = self.city + " " + self.location
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = "#events/#{self.id}"
    event
  end

  # Filter from main page
  #
  def self.main_filter(params)
    events = Event.includes(:image_attachment).all
    sql_params = []
    conditions = []

    if params.has_key?("filter_date") && !params[:filter_date].empty?
      if (params[:filter_date] == "last")
        conditions << ["event_date < ?"]
      elsif (params[:filter_date] == "future")
        conditions << ["event_date > ?"]
      end
      sql_params << DateTime.now
    end

    if params.has_key?("city") && !params[:city].empty?
      conditions << ["city LIKE ?"]
      sql_params << "%" + params[:city] + "%"
    end

    if params.has_key?("date_start") && !params[:date_start].empty?
      conditions << ["DATE(event_date) = ?"]
      sql_params << Time.parse(params[:date_start]).strftime('%Y/%m/%d')
    end

    events = events.where(conditions.join(' AND '), *sql_params)

    if params.has_key?("organizer") && !params[:organizer].empty?
      events = events.joins(:organizer).where('organizers.name LIKE ?', "%" + params[:organizer] + "%")
    end

    events.order("event_date DESC").paginate(:page => params[:page], :per_page => 8)
  end

  # Search by title or description
  #
  def self.search(search, page = 1)
    Event.where("title LIKE ? OR description LIKE ?", "%" + search + "%", "%" + search + "%")
         .order("event_date DESC").paginate(:page => page, :per_page => 8)
  end

  # Find events by event date
  #
  def self.find_by_date(date)
    begin
      date = date.to_date
    rescue
      date = Time.now + 86400 # so if we don`t get valid date, set tomorrow
    end

    Event.where('DATE(event_date) = ?', date)
  end
end
