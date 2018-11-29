class AddColumnScopedId < ActiveRecord::Migration
  def change
  	add_column :fb_bindings, :scoped_id, :integer, :after => :binding_ip
  end
end
