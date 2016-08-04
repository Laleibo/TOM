class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

def invoice
  customer = Stripe::Customer.retrieve(@profile.stripe_id)
  invoice_id = Stripe::Invoice.all(:customer => customer1.id).data[0][:id]
  total = Stripe::Invoice.all(:customer => customer1.id).data[0][:total]

  charge_id = Stripe::Invoice.all(:customer => customer1.id).data[0][:charge]

end

end
