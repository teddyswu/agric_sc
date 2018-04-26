class CreateUserFarmingCategoryShips < ActiveRecord::Migration
  def change
    create_table :user_farming_category_ships do |t|
    	t.integer :user_id
    	t.integer :farming_category_id

      t.timestamps null: false
    end
  end
end
