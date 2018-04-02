class ChangeFileTypeType < ActiveRecord::Migration
  def change
  	change_column :user_data, :file_type, :string
  end
end
