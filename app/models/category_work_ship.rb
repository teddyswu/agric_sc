class CategoryWorkShip < ActiveRecord::Base
  belongs_to :work_project
  belongs_to :farming_category
end
