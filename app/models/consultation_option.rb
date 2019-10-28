class ConsultationOption < ActiveRecord::Base
	belongs_to :consultation_cate
	has_many	:consultation_contents
	scope :normal_state, -> { where(:enabled => true) }
end
