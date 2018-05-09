class ChangeColumnShipAndCode < ActiveRecord::Migration
  def change
  	change_column :work_records, :category_work_ship_id, :string
  	change_column :work_records, :filed_code_id, :string
  	rename_column :work_records, :category_work_ship_id, :category_work
  	rename_column :work_records, :filed_code_id, :filed_code
  end
end
