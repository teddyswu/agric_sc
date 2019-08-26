class AddColumnIntoCons < ActiveRecord::Migration
  def change
  	add_column :consultations, :parameter_name, :string
  end
end
