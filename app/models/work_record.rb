class WorkRecord < ActiveRecord::Base
	belongs_to :user, :foreign_key => "owner_id"
	belongs_to :filed_code
  belongs_to :category_work_ship
end
