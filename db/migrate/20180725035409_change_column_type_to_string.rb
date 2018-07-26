class ChangeColumnTypeToString < ActiveRecord::Migration
  def change
  	change_column :work_record_logs, :owner_id, :string
  	change_column :work_record_logs, :record_type, :string
  	change_column :work_record_logs, :weight, :string
  	change_column :work_record_logs, :work_time, :string
  end
end
