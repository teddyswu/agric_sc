class CreateUserBehaviors < ActiveRecord::Migration
  def change
    create_table :user_behaviors do |t|
    	t.string :name
    	t.string :payload

      t.timestamps null: false
    end
  end
end
