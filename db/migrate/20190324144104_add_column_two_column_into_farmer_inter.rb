class AddColumnTwoColumnIntoFarmerInter < ActiveRecord::Migration
  def change
  	add_column :farmer_interactives, :release_time, :date, :after => :owner_id
  	add_column :farmer_interactives, :enabled, :boolean, :after => :release_time
  end
end
