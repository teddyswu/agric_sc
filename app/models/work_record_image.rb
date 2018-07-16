class WorkRecordImage < ActiveRecord::Base
	belongs_to :work_record

	scope :normal_state, -> { where(enabled: true) }
end
