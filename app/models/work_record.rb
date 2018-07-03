class WorkRecord < ActiveRecord::Base
	belongs_to :user, :foreign_key => "owner_id"
	has_many :work_record_images
	has_many :work_record_mood
	has_many :work_record_reply
end
