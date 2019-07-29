class CreateAutoReplies < ActiveRecord::Migration
  def change
    create_table :auto_replies do |t|
    	t.text :url
    	t.string	:default_pair
    	t.string	:triggering_pair
    	t.boolean	:enabled


      t.timestamps null: false
    end
  end
end
