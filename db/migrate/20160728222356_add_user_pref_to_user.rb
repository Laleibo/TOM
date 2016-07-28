class AddUserPrefToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :variety, :string
    add_column :users, :flow, :string
    add_column :users, :scent, :string
  end
end
