# frozen_string_literal: true

class Event < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :organizer
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  scope :city, ->(city) { where('city ILIKE ?', "%#{city}%") if city.present? }
  scope :date_start, ->(date_start) { where('DATE(event_date) = ?', Time.parse(date_start).strftime('%Y/%m/%d')) if date_start.present? }
  scope :past_or_future, ->(filter_date) do
    return unless filter_date.present?
    condition = filter_date == 'last'?  'event_date < ?' : 'event_date > ?'
    where(condition, DateTime.now)
  end
  scope :organizer, ->(organizer) { joins(:organizer).where('organizers.name ILIKE ?', "%#{organizer}%") if organizer.present? }

  validates :city, :location, :image, :organizer, presence: true
  validates :title, length: { minimum: 5, message: 'минимальное число символов 5' }, presence: true
  validates :link,
            format: { with: %r{\Ahttps?://[www]?[a-zA-Z0-9_-]*[.][a-z]{2,}(/.*)?\z},
                      message: 'введите корректный url адрес' }
  validates :event_date, presence: true
  validate :valid_datetime

  # Validate date format
  #
  def valid_datetime
    errors.add(:event_date, 'требуемый формат DD-MM-YYYY hh:mm') unless event_date.methods.include? :strftime
  end

  # Convert to iCalendar
  #
  def to_ics
    event = Icalendar::Event.new
    event.dtstart = event_date.strftime('%Y%m%dT%H%M%S')
    event.summary = title
    event.description = description
    event.location = "#{city} #{location}"
    event.ip_class = 'PUBLIC'
    event.created = created_at
    event.last_modified = updated_at
    event.uid = event.url = "#events/#{id}"
    event
  end

  # Search by title or description
  #
  def self.search(search, page = 1)
    Event.where('title ILIKE ? OR description ILIKE ?', "%#{search}%", "%#{search}%")
         .order('event_date DESC').paginate(page: page, per_page: 8)
  end

  # Find events by event date
  #
  def self.find_by_date(date)
    begin
      date = date.to_date
    rescue StandardError
      date = Time.now + 86_400 # so if we don`t get valid date, set tomorrow
    end

    Event.where('DATE(event_date) = ?', date)
  end
end
