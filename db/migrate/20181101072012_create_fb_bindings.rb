class CreateFbBindings < ActiveRecord::Migration
  def change
    create_table :fb_bindings do |t|
    	t.text :binding_ip

      t.timestamps null: false
    end
  end
end
