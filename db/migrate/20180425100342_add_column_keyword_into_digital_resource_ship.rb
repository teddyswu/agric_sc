class AddColumnKeywordIntoDigitalResourceShip < ActiveRecord::Migration
  def change
  	add_column :digital_resource_ships, :keyword, :string, :after => :resource_id
  end
end
