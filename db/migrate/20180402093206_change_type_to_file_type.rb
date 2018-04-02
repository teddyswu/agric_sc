class ChangeTypeToFileType < ActiveRecord::Migration
  def change
  	rename_column :user_data, :type, :file_type
  end
end
