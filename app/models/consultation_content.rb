class ConsultationContent < ActiveRecord::Base
	belongs_to :consultation_options
	scope :normal_state, -> { where(:enabled => true) }
end
