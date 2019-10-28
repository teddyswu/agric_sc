class FarmerProfileFarmingCategoryShip < ActiveRecord::Base
	belongs_to :farmer_profile
  belongs_to :farming_category
end
