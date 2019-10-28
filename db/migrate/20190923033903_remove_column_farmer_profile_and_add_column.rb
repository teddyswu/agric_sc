class RemoveColumnFarmerProfileAndAddColumn < ActiveRecord::Migration
  def change
  	remove_column :farmer_profiles, :gender
  	remove_column :farmer_profiles, :birthday
  	remove_column :farmer_profiles, :ps_group
  	remove_column :farmer_profiles, :fb_uid
  	remove_column :farmer_profiles, :certificate_photo_2
  	remove_column :farmer_profiles, :farm_name
  	remove_column :farmer_profiles, :name
  	add_column :farmer_profiles, :email, :string, :after => :user_pic_url
  	add_column :farmer_profiles, :status, :boolean, :after => :validity_period
  	add_column :farmer_profiles, :verification_status, :integer, :after => :category
  end
end
