class FarmingCategory < ActiveRecord::Base
	has_many :user_farming_category_ships
	has_many :users, :through => :user_farming_category_ships
end
