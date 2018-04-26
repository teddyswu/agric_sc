class UserFarmingCategoryShip < ActiveRecord::Base
	belongs_to :user
	belongs_to :farming_category
end
