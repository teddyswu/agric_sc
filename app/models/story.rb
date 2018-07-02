class Story < ActiveRecord::Base
	has_many :story_tag_ships
  has_many :story_tags, :through => :story_tag_ships
  has_one :story_image
end
