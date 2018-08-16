class WorkDiaryImage < ActiveRecord::Base
	belongs_to :work_diary
	scope :normal_state, -> { where(enabled: true) }
end
