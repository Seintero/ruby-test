class Event < ApplicationRecord
  has_one_attached :image
  belongs_to :organizer
  validates :title, :city, :location, :link, :event_date, :image, presence: true
end
