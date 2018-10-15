class RenameTableUserProfileToFarmerProfile < ActiveRecord::Migration
  def change
  	rename_table :user_profiles, :farmer_profiles
  end
end
