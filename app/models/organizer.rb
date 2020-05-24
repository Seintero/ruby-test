class Organizer < ApplicationRecord
  has_many :events, dependent: :destroy
end
