class CreateUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :user_subscriptions do |t|
    	t.string :scoped_id
    	t.string :full_name

      t.timestamps null: false
    end
  end
end
