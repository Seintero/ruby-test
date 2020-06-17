class Event < ApplicationRecord
  has_one_attached :image
  belongs_to :organizer
  validates :city, :location, :image, :organizer, presence: true
  validates :title, length: {minimum: 5, message: "Минимальное число символов 5"}, presence: true
  validates :link, format: {with: /\Ahttps?:\/\/[www]?[a-zA-Z0-9_-]*[.][a-z]{2,}\z/, message: "Введите корректный url адрес"}
  validates :event_date, presence: true
  validate :image_size, :valid_datetime

  def image_size
    if image.attached?
      if image.byte_size > 1000000
        errors.add(:image, "Размер файла превышает 1MB")
      elsif !image.content_type.starts_with?('image/')
        errors.add(:image, "Файл не относится к изображениям")
      end
    end
  end

  def valid_datetime
    unless (event_date.methods.include? :strftime)
      errors.add(:event_date, "Дата мероприятия должна быть в DD-MM-YYYY hh:mm")
    end
  end

  # Convert to iCalendar
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

end
