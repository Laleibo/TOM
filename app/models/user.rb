class User < ApplicationRecord
  belongs_to :profile
  has_many :orders
  has_many :products, through: :orders

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :variety, presence: true
  # validates :flow, presence: true
  # validates :scent, presence: true

  def self.birthday_day(birthday)
    birthday.strftime('%B %e %Y')
  end

end
