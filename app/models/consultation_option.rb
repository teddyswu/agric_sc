class ConsultationOption < ActiveRecord::Base
	belongs_to :consultation_cate
	has_many	:consultation_contents
end
