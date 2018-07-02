class CreateStoryTagShips < ActiveRecord::Migration
  def change
    create_table :story_tag_ships do |t|
    	t.integer :story_id
    	t.integer :story_tag_id

      t.timestamps null: false
    end
  end
end
