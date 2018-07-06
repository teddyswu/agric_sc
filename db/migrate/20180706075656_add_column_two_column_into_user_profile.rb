class AddColumnTwoColumnIntoUserProfile < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :gender, :integer, :after => :user_pic_url
  	add_column :user_profiles, :birthday, :datetime, :after => :gender
  end
end
