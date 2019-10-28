class FarmerProfileUserShip < ActiveRecord::Base
	belongs_to :farmer_profile
  belongs_to :user
end
