class ChangeColumnParameterSetIdToString < ActiveRecord::Migration
  def change
  	change_column :parameter_jsons, :parameter_set_id, :string
  	rename_column :parameter_jsons, :parameter_set_id, :parameter_set_id_type
  end
end
