class AddColumnToWordingJson < ActiveRecord::Migration
  def change
  	add_column :wording_jsons, :def_name, :string, :after => :name
  	add_column :parameter_jsons, :def_name, :string, :after => :name
  end
end
