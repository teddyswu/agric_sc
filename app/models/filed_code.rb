class FiledCode < ActiveRecord::Base
	has_many :work_records
  has_many :category_work_ships, :through => :work_records
end
