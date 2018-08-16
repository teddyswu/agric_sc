class CreateWorkDiaryImages < ActiveRecord::Migration
  def change
    create_table :work_diary_images do |t|
    	t.integer :work_diary_id
    	t.text :url
    	t.text :cover_url
    	t.text :origin_url
    	t.text :show_url
    	t.boolean :enabled

      t.timestamps null: false
    end
  end
end
