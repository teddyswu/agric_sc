class CreateHeadlines < ActiveRecord::Migration
  def change
    create_table :headlines do |t|
    	t.string :resource_type
    	t.integer	:resource_id

      t.timestamps null: false
    end
  end
end
