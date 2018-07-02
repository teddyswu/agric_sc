class ChangeColumnStoryTag < ActiveRecord::Migration
  def change
  	change_column :story_tags, :name, :string
  end
end
