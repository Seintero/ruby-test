class Organizer < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :name, uniqueness: {case_sensitive: false, message: " должено быть уникальным"}, presence: {message: "не может быть пустым"}
  validates :description, length: {maximum: 255, message: "максимальное число символов 255"}
end