class AddTwoColumnIntoStories < ActiveRecord::Migration
  def change
  	add_column :stories, :easter_egg_name, :string, :after => :story_cat_id
  	add_column :stories, :easter_egg_url, :text, :after => :easter_egg_name
  end
end
