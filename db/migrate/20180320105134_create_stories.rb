class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
    	t.string :title
    	t.text	:content
    	t.string :owner

      t.timestamps null: false
    end
  end
end
