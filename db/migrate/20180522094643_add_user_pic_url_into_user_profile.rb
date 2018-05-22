class AddUserPicUrlIntoUserProfile < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :pic_url, :text, :after => :user_id
  end
end
