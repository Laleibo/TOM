class User < ApplicationRecord  
  belongs_to :profile
  has_many :orders
  has_many :products, through: :orders
end
