class CreateTypeGifs < ActiveRecord::Migration
  def change
    create_table :type_gifs do |t|
    	t.text :url, :null => false
      t.timestamps null: false
    end
  end
end
