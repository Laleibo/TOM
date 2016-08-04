class Profile < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders


validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, confirmation: true, case_sensitive: false
# validates :password, confirmation: true, length: { minimum: 8 }

  validate :future_delivery
# validates :zip, length: { minimum: 5 }

  def future_delivery
    errors.add(:delivery, 'error message') unless self.delivery.future?
  end


  geocoded_by :address
    def address
      [address1, address2, city, state, zip].compact.join(', ')
    end


end
