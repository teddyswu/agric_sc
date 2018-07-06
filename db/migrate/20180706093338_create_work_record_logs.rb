class CreateWorkRecordLogs < ActiveRecord::Migration
  def change
    create_table :work_record_logs do |t|
    	t.string   :farming_category
    	t.string   :filed_code
    	t.integer  :owner_id
    	t.integer  :record_type
    	t.float    :weight
    	t.datetime :work_time
    	t.string   :work_project

      t.timestamps null: false
    end
  end
end
