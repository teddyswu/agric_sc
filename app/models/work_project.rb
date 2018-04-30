class WorkProject < ActiveRecord::Base
	has_many :category_work_ships
  has_many :farming_category, :through => :category_work_ships
end
