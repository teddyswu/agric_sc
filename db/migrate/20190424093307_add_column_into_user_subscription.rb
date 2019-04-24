class AddColumnIntoUserSubscription < ActiveRecord::Migration
  def change
  	add_column :user_subscriptions, :cat, :integer
  end
end
