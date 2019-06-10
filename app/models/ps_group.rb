class PsGroup < ActiveRecord::Base
	has_many :farmer_profiles

	scope :normal_state, -> { where(enabled: true) }
end
