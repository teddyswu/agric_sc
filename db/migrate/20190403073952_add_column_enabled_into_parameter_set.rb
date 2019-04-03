class AddColumnEnabledIntoParameterSet < ActiveRecord::Migration
  def change
  	add_column :parameter_sets, :enabled, :boolean, :after => :user
  	rename_column :parameter_sets, :arg, :ref
  end
end
