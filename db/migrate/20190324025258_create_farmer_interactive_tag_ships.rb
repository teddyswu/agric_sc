class CreateFarmerInteractiveTagShips < ActiveRecord::Migration
  def change
    create_table :farmer_interactive_tag_ships do |t|
    	t.integer :farmer_interactive_id
    	t.integer	:farmer_interactive_tag_id

      t.timestamps null: false
    end
  end
end
