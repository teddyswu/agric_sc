class FarmingCategory < ActiveRecord::Base
	has_many :user_farming_category_ships
	has_many :users, :through => :user_farming_category_ships

	has_many :category_work_ships
  has_many :work_projects, :through => :category_work_ships
end
