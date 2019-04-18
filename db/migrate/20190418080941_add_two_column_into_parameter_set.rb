class AddTwoColumnIntoParameterSet < ActiveRecord::Migration
  def change
  	add_column :parameter_sets, :cat, :integer, :after => :user
  	add_column :parameter_sets, :wording_id, :integer, :after => :cat
  end
end
