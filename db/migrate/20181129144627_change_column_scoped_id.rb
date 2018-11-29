class ChangeColumnScopedId < ActiveRecord::Migration
  def change
  	change_column :fb_bindings, :scoped_id, :text
  end
end
