class AddEmailConfirmationToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :email_confirmed, :boolean, :default => false
    add_column :profiles, :confirm_token, :string
  end
end
