class RenameColumnCategoryWork < ActiveRecord::Migration
  def change
  	rename_column :work_records, :category_work, :farming_category
  	add_column :work_records, :work_project, :string
  end
end
