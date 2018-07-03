class CreateWorkRecordMoods < ActiveRecord::Migration
  def change
    create_table :work_record_moods do |t|
    	t.integer	:work_record_id
    	t.integer :user_id
    	t.integer :mood

      t.timestamps null: false
    end
  end
end
