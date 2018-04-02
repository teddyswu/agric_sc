class AddTypeToUserdatum < ActiveRecord::Migration
  def change
  	add_column :user_data, :type, :integer, :after => :user_data
  end
end
