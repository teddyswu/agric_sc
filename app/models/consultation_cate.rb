class ConsultationCate < ActiveRecord::Base
	has_many :consultation_options
	belongs_to :consultation
end
