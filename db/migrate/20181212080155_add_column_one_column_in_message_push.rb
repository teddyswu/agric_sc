class AddColumnOneColumnInMessagePush < ActiveRecord::Migration
  def change
  	add_column :message_pushes, :total_number, :integer, :after => :read_number
  end
end
