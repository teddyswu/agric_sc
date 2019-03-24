class FarmerInteractiveTag < ActiveRecord::Base
	has_many :farmer_interactive_tag_ships
  has_many :farmer_interactives, :through => :story_tag_ships
end
