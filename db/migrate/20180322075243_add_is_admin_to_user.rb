class AddIsAdminToUser < ActiveRecord::Migration
  def change
  	add_column :users, :is_admin, :boolean, :after => :last_sign_in_ip
  	add_column :users, :is_farmer, :boolean, :after => :is_admin
  	add_column :users, :is_check_farmer, :boolean, :after => :is_farmer
  	add_column :users, :encryption, :text, :after => :email
  end
end
