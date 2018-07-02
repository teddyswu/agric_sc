class CreateStoryImages < ActiveRecord::Migration
  def change
    create_table :story_images do |t|
    	t.integer :story_id
    	t.string	:file
    	t.text		:url_headline
    	t.text		:url_cover

      t.timestamps null: false
    end
  end
end
