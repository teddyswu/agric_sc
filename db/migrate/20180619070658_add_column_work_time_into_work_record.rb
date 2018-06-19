class AddColumnWorkTimeIntoWorkRecord < ActiveRecord::Migration
  def change
  	add_column :work_records , :work_time, :datetime, :after => :weight
  end
end
