class Event < ApplicationRecord
  belongs_to :organizer
  has_one_attached :image
end
