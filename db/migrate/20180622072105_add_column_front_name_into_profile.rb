class AddColumnFrontNameIntoProfile < ActiveRecord::Migration
  def change
  	add_column :user_profiles , :front_name, :string, :after => :ps_group
  end
end
