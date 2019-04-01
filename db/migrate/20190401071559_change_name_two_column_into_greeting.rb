class ChangeNameTwoColumnIntoGreeting < ActiveRecord::Migration
  def change
  	rename_column :greetings, :f_id, :uid
  	rename_column :greetings, :origin, :ref
  	rename_column :greetings, :is_start_use, :start
  end
end
