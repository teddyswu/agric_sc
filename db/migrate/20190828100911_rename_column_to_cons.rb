class RenameColumnToCons < ActiveRecord::Migration
  def change
  	rename_column :consultations, :type, :cat
  end
end
