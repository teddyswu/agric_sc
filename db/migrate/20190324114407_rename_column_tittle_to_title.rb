class RenameColumnTittleToTitle < ActiveRecord::Migration
  def change
  	rename_column :farmer_interactives, :tittle, :title
  end
end
