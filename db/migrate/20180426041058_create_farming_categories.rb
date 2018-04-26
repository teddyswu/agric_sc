class CreateFarmingCategories < ActiveRecord::Migration
  def change
    create_table :farming_categories do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
