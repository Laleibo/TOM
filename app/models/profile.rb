class Profile < ApplicationRecord
  before_create :confirmation_token
  has_secure_password
  has_many :users
  has_many :orders, through: :users
  has_many :products, through: :orders

validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, confirmation: true, case_sensitive: false
# validates :password, confirmation: true, length: { minimum: 8 }


  # geocoded_by :address
    def address
      [address1, address2, city, state, zip].compact.join(', ')
    end

  def self.total_amount(id)
    profile = Profile.find(id)
    customer = Stripe::Customer.retrieve(profile.stripe_id)
    total = Stripe::Invoice.all(:customer => customer.id).data[0][:total] /100
    amount = "$ #{'%.2f' % total}"
  end

  def self.delivery_day(delivery)
    delivery.strftime('%d').to_i.ordinalize
  end

  def self.invoice_date(id)
    profile = Profile.find(id)
    customer = Stripe::Customer.retrieve(profile.stripe_id)
    date = Time.at(Stripe::Invoice.all(:customer => customer.id).data[0][:date])
    date.strftime('%D')
  end

  def self.status(id)
    profile = Profile.find(id)
    customer = Stripe::Customer.retrieve(profile.stripe_id)
    status = Stripe::Invoice.all(:customer => customer.id).data[0][:paid]
      if status == true
        return "paid"
      else
        return "processing"
      end
  end

  def self.boxes(id)
    profile = Profile.find(id)
    Profile.find(id).users.count
  end


  # def self.invoice_line(id)
  #   profile = Profile.find(id)
  #   customer = Stripe::Customer.retrieve(profile.stripe_id)
  #    invoice_id = Stripe::Invoice.all(:customer => customer.id).data[0][:id]
  #    charge_id = Stripe::Invoice.all(:customer => customer.id).data[0][:charge]
  #    Stripe::Invoice.retrieve(:customer => customer.id).lines.all({
  #   :limit => 5})
  # end

  private
    def confirmation_token
        if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
end
