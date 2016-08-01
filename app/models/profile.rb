class Profile < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders


validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, confirmation: true
# validates :password, confirmation: true, length: { minimum: 8 }, :if => :password

end
