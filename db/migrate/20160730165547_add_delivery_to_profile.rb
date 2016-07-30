class AddDeliveryToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :delivery, :date
  end
end
