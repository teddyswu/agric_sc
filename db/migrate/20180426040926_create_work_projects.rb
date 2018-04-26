class CreateWorkProjects < ActiveRecord::Migration
  def change
    create_table :work_projects do |t|
    	t.string :name
    	t.integer :record_type

      t.timestamps null: false
    end
  end
end
