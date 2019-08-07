class RenameColumnRuleCatToRuleType < ActiveRecord::Migration
  def change
  	rename_column :auto_reply_rules, :rule_cat, :rule_type
  end
end
