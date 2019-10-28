class RemoveColumnFrontName < ActiveRecord::Migration
  def change
  	remove_column :farmer_profiles, :front_name
  	add_column :farmer_profiles, :farm_name, :string, :after => :ps_group_id
  end
end
