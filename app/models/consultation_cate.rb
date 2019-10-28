class ConsultationCate < ActiveRecord::Base
	has_many :consultation_options
	belongs_to :consultation

	scope :normal_state, -> { where(:enabled => true) }
end
