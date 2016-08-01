class Profile < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders


validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, confirmation: true, case_sensitive: false
# validates :password, confirmation: true, length: { minimum: 8 }, :if => :password
# validates :zip, is: => 5, :message => "Your zip code must be exactly 5 numbers"
end
