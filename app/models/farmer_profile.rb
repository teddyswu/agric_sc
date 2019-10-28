class FarmerProfile < ActiveRecord::Base
	belongs_to :user
	belongs_to :ps_group

	has_many :farmer_profile_user_ships
  has_many :users, :through => :farmer_profile_user_ships

  has_many :farmer_profile_farming_category_ships
  has_many :farming_categories, :through => :farmer_profile_farming_category_ships
end
