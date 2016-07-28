class AddStripeCardTokenToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :card_token, :string
  end
end
