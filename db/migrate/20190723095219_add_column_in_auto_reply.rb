class AddColumnInAutoReply < ActiveRecord::Migration
  def change
  	add_column :auto_replies, :name, :string, :after => :id
  end
end
