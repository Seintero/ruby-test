class Subscriber < ApplicationRecord
  validates :email, uniqueness: {   message: "уже есть в рассылке" } , format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "не корректен"}
  scope :all_active, -> { where("active = true") }
end
