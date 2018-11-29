class ChangeColumnModelName < ActiveRecord::Migration
  def change
  	rename_column :message_pushes, :model_name, :module_name
  end
end
