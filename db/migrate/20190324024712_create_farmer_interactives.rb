class CreateFarmerInteractives < ActiveRecord::Migration
  def change
    create_table :farmer_interactives do |t|
    	t.string :tittle
    	t.text	:content
    	t.integer :woner_id
    	

      t.timestamps null: false
    end
  end
end
