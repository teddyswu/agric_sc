class CreateWorkRecordImages < ActiveRecord::Migration
  def change
    create_table :work_record_images do |t|
    	t.integer :work_record_id
    	t.text :url

      t.timestamps null: false
    end
    remove_column :work_records, :photo
    remove_column :work_records, :photo_2
  end
end
