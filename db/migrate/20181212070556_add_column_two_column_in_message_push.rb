class AddColumnTwoColumnInMessagePush < ActiveRecord::Migration
  def change
  	add_column :message_pushes, :delivery_number, :integer, :after => :run_at
  	add_column :message_pushes, :read_number, :integer, :after => :delivery_number
  end
end
