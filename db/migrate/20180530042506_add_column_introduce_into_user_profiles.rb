class AddColumnIntroduceIntoUserProfiles < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :introduce, :text, :after => :crop_name
  end
end
