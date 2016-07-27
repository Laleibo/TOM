class Product < ApplicationRecord
  has_many :users, through: :orders
  has_many :orders
end
