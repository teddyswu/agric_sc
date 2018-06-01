class AddColumnIntroduceIntoUserImages < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :user_pic_url, :text, :after => :user_id
  	add_column :user_images, :user_id, :integer, :after => :id
  end
end
