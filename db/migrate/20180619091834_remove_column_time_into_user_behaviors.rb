class RemoveColumnTimeIntoUserBehaviors < ActiveRecord::Migration
  def change
  	remove_column :user_behaviors , :time
  end
end
