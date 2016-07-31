class Profile < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders

validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, confirmation: true
validates :password, confirmation: true, length: { minimum: 8 }


# def process_payment
# customer = Stripe::Customer.create email: email,
#                                        card: card_token
#
#     Stripe::Charge.create customer: customer.id,
#                           amount: product.price * 100,
#                           description: product.name,
#                           currency: 'usd'

  # end

end
