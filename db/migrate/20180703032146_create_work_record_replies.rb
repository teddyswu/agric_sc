class CreateWorkRecordReplies < ActiveRecord::Migration
  def change
    create_table :work_record_replies do |t|
    	t.integer :work_record_id
    	t.integer :user_id
    	t.text		:content
    	t.boolean	:enabled

      t.timestamps null: false
    end
  end
end
