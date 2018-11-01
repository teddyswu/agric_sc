class CreateFbTracks < ActiveRecord::Migration
  def change
    create_table :fb_tracks do |t|
    	t.string :scoped_id
    	t.integer :campaign_id

      t.timestamps null: false
    end
  end
end
