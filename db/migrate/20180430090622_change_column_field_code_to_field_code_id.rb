class ChangeColumnFieldCodeToFieldCodeId < ActiveRecord::Migration
  def change
  	rename_column :work_records, :field_code, :filed_code_id
  end
end
