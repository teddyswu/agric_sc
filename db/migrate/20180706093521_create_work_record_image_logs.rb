class CreateWorkRecordImageLogs < ActiveRecord::Migration
  def change
    create_table :work_record_image_logs do |t|
    	t.integer  :work_record_log_id
    	t.text     :url

      t.timestamps null: false
    end
  end
end
