class AddPic2ToUserProfile < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :ps_group, :string, :after => :farm_name
  	add_column :user_profiles, :certificate_photo_2, :text, :after => :certificate_photo
  	add_column :user_profiles, :oc_num, :string, :after => :certificate_photo_2
  end
end
