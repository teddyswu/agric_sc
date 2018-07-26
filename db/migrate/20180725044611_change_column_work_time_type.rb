class ChangeColumnWorkTimeType < ActiveRecord::Migration
  def change
  	change_column :work_record_logs, :work_time, :datetime
  end
end
