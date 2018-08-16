class CreateWorkDiaries < ActiveRecord::Migration
  def change
    create_table :work_diaries do |t|
    	t.integer :owner_id
    	t.text :comment
    	t.datetime :diary_time

      t.timestamps null: false
    end
  end
end
