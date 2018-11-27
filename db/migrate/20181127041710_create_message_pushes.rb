class CreateMessagePushes < ActiveRecord::Migration
  def change
    create_table :message_pushes do |t|
    	t.string :model_name
    	t.datetime :push_time
    	

      t.timestamps null: false
    end
  end
end
