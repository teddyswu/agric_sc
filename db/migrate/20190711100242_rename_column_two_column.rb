class RenameColumnTwoColumn < ActiveRecord::Migration
  def change
  	rename_column :specify_keywords, :model_name, :resource_type
  	rename_column :specify_keywords, :model_id, :resource_id
  end
end
