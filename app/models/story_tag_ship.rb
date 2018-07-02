class StoryTagShip < ActiveRecord::Base
	belongs_to :story
  belongs_to :story_tag
end
