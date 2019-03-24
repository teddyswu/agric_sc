class CreateFarmerInteractiveTags < ActiveRecord::Migration
  def change
    create_table :farmer_interactive_tags do |t|
    	t.integer	:farmer_interactive_tag_id
    	t.string	:interactive_tag_name

      t.timestamps null: false
    end
  end
end
