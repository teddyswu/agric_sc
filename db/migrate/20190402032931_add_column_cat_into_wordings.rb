class AddColumnCatIntoWordings < ActiveRecord::Migration
  def change
  	add_column :wordings, :cat, :integer, :after => :content
  end
end
