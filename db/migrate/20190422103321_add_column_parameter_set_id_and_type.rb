class AddColumnParameterSetIdAndType < ActiveRecord::Migration
  def change
  	rename_column :parameter_jsons, :parameter_set_id_type, :parameter_set_id
  	change_column :parameter_jsons, :parameter_set_id, :integer
  	add_column :parameter_jsons, :parameter_set_type, :string, :after => :parameter_set_id
  end
end
