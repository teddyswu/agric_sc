class RemoveColumnFarmerInteractiveTagId < ActiveRecord::Migration
  def change
  	remove_column :farmer_interactive_tags, :farmer_interactive_tag_id
  end
end
