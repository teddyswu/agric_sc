class CreateReplyWords < ActiveRecord::Migration
  def change
    create_table :reply_words do |t|
    	t.string :category
    	t.string	:show_name
    	t.datetime :start_time
    	t.datetime :end_time
    	t.boolean :enabled

      t.timestamps null: false
    end
  end
end
