class Profile < ApplicationRecord
  before_create :confirmation_token
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders

validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, confirmation: true, case_sensitive: false
# validates :password, confirmation: true, length: { minimum: 8 }

# validates :zip, length: { minimum: 5 }

geocoded_by :address
  def address
    [address1, address2, city, state, zip].compact.join(', ')
  end

  private
    def confirmation_token
        if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
end
