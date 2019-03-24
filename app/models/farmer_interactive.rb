class FarmerInteractive < ActiveRecord::Base
	has_many :farmer_interactive_tag_ships
  has_many :farmer_interactive_tags, :through => :farmer_interactive_tag_ships
  belongs_to :user, :foreign_key => "owner_id"
end
