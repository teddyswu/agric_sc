class WorkDiary < ActiveRecord::Base
	belongs_to :user, :foreign_key => "owner_id"
	has_many :work_diary_images
end
