class CreateAutoReplyMessages < ActiveRecord::Migration
  def change
    create_table :auto_reply_messages do |t|
    	t.integer	:auto_reply_id
    	t.string	:cat
    	t.text		:content
    	t.boolean	:is_default

      t.timestamps null: false
    end
  end
end
