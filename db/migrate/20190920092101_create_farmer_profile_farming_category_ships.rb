class CreateFarmerProfileFarmingCategoryShips < ActiveRecord::Migration
  def change
    create_table :farmer_profile_farming_category_ships do |t|
    	t.integer	:farmer_profile_id
    	t.integer	:farming_category_id

      t.timestamps null: false
    end
  end
end
