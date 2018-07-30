class CreateFbToAws < ActiveRecord::Migration
  def change
    create_table :fb_to_aws do |t|
    	t.string :file
    	t.text	:cover_url
    	t.text	:origin_url

      t.timestamps null: false
    end
  end
end
