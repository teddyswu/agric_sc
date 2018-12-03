class CreateGroupUserShips < ActiveRecord::Migration
  def change
    create_table :group_user_ships do |t|
    	t.integer :group_id
    	t.integer :user_id

      t.timestamps null: false
    end
    remove_column :message_pushes, :user_list
    add_column :message_pushes, :group_id, :integer
  end
end
