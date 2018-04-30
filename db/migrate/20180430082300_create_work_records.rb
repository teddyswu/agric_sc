class CreateWorkRecords < ActiveRecord::Migration
  def change
    create_table :work_records do |t|
    	t.integer :category_work_ship_id
    	t.integer :field_code
    	t.text :photo
    	t.text :photo_2
    	t.integer :owner_id

      t.timestamps null: false
    end
  end
end
