class Organizer < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :name, uniqueness: {   message: "Организатор должен быть уникальным" } , presence:  {   message: "не может быть пустым" }
end
