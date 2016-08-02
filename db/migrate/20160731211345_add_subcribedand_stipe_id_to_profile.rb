class AddSubcribedandStipeIdToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :subscribed, :boolean
    add_column :profiles, :stripe_id, :string
  end
end
