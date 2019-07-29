class AddTwoColumn < ActiveRecord::Migration
  def change
  	add_column :auto_reply_messages, :group_id, :integer, :after => :content
  	add_column :auto_reply_replies, :group_id, :integer, :after => :content
  end
end
