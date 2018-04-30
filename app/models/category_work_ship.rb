class CategoryWorkShip < ActiveRecord::Base
	has_many :work_records
  has_many :filed_code, :through => :work_records

  belongs_to :work_project
  belongs_to :farming_category
end
