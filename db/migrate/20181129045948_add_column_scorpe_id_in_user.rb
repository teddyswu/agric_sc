class AddColumnScorpeIdInUser < ActiveRecord::Migration
  def change
  	add_column :user_behaviors, :scoped_id, :text, :after => :name
  end
end
