class RenameColumnUserIdToUid < ActiveRecord::Migration
  def change
  	rename_column :group_user_ships, :user_id, :uid
  	change_column :group_user_ships, :uid, :string
  end
end
