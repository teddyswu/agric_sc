class CreateParameterSets < ActiveRecord::Migration
  def change
    create_table :parameter_sets do |t|
    	t.string :arg
    	t.text	:guest
    	t.text	:subscribe_guest
    	t.text	:user

      t.timestamps null: false
    end
  end
end
