class RenameColumnUserAnalyzes < ActiveRecord::Migration
  def change
  	rename_column :user_analyzes, :f_id, :uid
  	rename_column :user_analyzes, :origin, :pl
  	rename_column :user_analyzes, :keyword, :ref
  	remove_column :user_analyzes, :send_to_module

  end
end
