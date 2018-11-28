class AddColumnCompleteTime < ActiveRecord::Migration
  def change
  	add_column :message_pushes, :complete_time, :datetime, :after => :delayed_job_id
  end
end
