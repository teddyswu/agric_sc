class StoryTag < ActiveRecord::Base
	has_many :story_tag_ships
  has_many :storys, :through => :story_tag_ships
end
