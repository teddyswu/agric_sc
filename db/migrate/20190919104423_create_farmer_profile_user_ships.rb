class CreateFarmerProfileUserShips < ActiveRecord::Migration
  def change
    create_table :farmer_profile_user_ships do |t|
    	t.integer	:farmer_profile_id
    	t.integer	:user_id
    	t.integer	:permission
    	t.string	:uid

      t.timestamps null: false
    end
  end
end
