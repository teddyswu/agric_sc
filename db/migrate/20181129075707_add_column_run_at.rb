class AddColumnRunAt < ActiveRecord::Migration
  def change
  	add_column :message_pushes, :run_at, :datetime, :after => :delayed_job_id
  end
end
