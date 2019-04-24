class CreateParameterJsons < ActiveRecord::Migration
  def change
    create_table :parameter_jsons do |t|
    	t.string	:name
    	t.text	:json
    	t.integer	:parameter_set_id
      t.timestamps null: false
    end
    add_column :parameter_sets, :name, :string, :after => :id
  end
end
