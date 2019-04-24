class AddColumnIntoFbBinding < ActiveRecord::Migration
  def change
  	add_column :fb_bindings, :module_name, :string, :after => :scoped_id
  end
end
