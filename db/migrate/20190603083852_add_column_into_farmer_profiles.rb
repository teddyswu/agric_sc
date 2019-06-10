class AddColumnIntoFarmerProfiles < ActiveRecord::Migration
  def change
  	add_column :farmer_profiles, :ps_group_id, :integer, :after => :ps_group
  end
end
