# frozen_string_literal: true

class Subscriber < ApplicationRecord
  before_save { email.downcase! }
  validates :email, uniqueness: { case_sensitive: false, message: 'уже есть в рассылке' },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'не корректен' }
  scope :all_active, -> { where('active = true') }
end
