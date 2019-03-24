class RenameColumnWonerIdToOwnerId < ActiveRecord::Migration
  def change
  	rename_column :farmer_interactives, :woner_id, :owner_id
  	rename_column :farmer_interactive_tags, :interactive_tag_name, :name
  end
end
