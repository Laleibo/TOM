class AddColumnsToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :variety, :string
    add_column :products, :flow, :string
    add_column :products, :scent, :string
  end
end
