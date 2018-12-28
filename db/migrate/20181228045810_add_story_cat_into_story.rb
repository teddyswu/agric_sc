class AddStoryCatIntoStory < ActiveRecord::Migration
  def change
  	add_column :stories, :story_cat_id, :integer, :after => :owner
  end
end
