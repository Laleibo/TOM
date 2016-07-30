class User < ApplicationRecord
  belongs_to :profile
  has_many :orders
  has_many :products, through: :orders


validates :first_name, presence: {message: "Enter a first name"}
validates :last_name, presence: {message: "Enter a last name "}
validates :variety, presence: {message: "Choose the type of feminine product"}
validates :flow, presence: {message: "Choose the type of flow box"}
validates :scent, presence: {message: "Choose if you want scented or unscented "}
end
