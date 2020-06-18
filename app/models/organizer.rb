class Organizer < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :name, uniqueness: {   message: "Организатор должен быть уникальным" } , presence:  {   message: "не может быть пустым" }
  validates :description, length: {maximum: 255, message: "Максимальное число символов 255"}
end