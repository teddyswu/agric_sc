class RemoveColumnPushTime < ActiveRecord::Migration
  def change
  	remove_column :message_pushes, :push_time
  	add_column :message_pushes, :user_list, :string, :after => :model_name
  	add_column :message_pushes, :delayed_job_id, :integer, :after => :user_list 
  end
end
