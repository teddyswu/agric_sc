class CreateCategoryWorkShips < ActiveRecord::Migration
  def change
    create_table :category_work_ships do |t|
    	t.integer :farming_category_id
    	t.integer :work_projects_id

      t.timestamps null: false
    end
  end
end
