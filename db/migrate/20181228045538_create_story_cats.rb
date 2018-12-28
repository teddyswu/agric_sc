class CreateStoryCats < ActiveRecord::Migration
  def change
    create_table :story_cats do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
