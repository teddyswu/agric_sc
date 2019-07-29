class CreateAutoReplyRules < ActiveRecord::Migration
  def change
    create_table :auto_reply_rules do |t|
    	t.integer	:auto_reply_id
    	t.string	:rule_cat
    	t.string	:rule
    	t.integer	:parent_id

      t.timestamps null: false
    end
  end
end
