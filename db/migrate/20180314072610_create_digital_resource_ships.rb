class CreateDigitalResourceShips < ActiveRecord::Migration
  def change
    create_table :digital_resource_ships do |t|
    	t.string :resource_type, :null => false
    	t.integer	:resource_id, :null => false
    	t.text		:encryption, :null => false
    	t.text 		:title, :null => false
      t.timestamps null: false
    end
  end
end
