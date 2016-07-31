class Profile < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders

def self.quantity
  @profile.users.count
end


end
