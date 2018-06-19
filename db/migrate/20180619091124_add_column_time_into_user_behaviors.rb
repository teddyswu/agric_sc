class AddColumnTimeIntoUserBehaviors < ActiveRecord::Migration
  def change
  	add_column :user_behaviors , :time, :datetime, :after => :payload
  end
end
