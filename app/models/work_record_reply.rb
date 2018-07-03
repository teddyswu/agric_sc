class WorkRecordReply < ActiveRecord::Base
	belongs_to :work_record
	belongs_to :user
end
