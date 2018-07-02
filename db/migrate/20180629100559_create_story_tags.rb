class CreateStoryTags < ActiveRecord::Migration
  def change
    create_table :story_tags do |t|
    	t.integer :name

      t.timestamps null: false
    end
  end
end
