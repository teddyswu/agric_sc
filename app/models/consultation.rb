class Consultation < ActiveRecord::Base
	has_many :consultation_cates

	scope :normal_state, -> { where(:enabled => true) }
end
