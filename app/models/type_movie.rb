class TypeMovie < ActiveRecord::Base
	has_many :digital_resource_ships
	accepts_nested_attributes_for :digital_resource_ships,    :allow_destroy => true
end
