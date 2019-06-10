class FarmerProfile < ActiveRecord::Base
	belongs_to :user
	belongs_to :ps_group
end
