class CreatePsGroups < ActiveRecord::Migration
  def change
    create_table :ps_groups do |t|
    	t.string :name
    	t.boolean :enabled
    	

      t.timestamps null: false
    end
  end
end
