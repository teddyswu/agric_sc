class AddColumnPurposeIntoMessagerPush < ActiveRecord::Migration
  def change
  	add_column :message_pushes, :purpose, :text, :after => :total_number
  end
end
