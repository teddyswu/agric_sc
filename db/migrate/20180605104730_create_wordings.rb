class CreateWordings < ActiveRecord::Migration
  def change
    create_table :wordings do |t|
    	t.string :name
    	t.text	:content

      t.timestamps null: false
    end
  end
end
