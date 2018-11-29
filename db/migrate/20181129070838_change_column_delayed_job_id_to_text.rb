class ChangeColumnDelayedJobIdToText < ActiveRecord::Migration
  def change
  	change_column :message_pushes, :delayed_job_id, :text
  end
end
