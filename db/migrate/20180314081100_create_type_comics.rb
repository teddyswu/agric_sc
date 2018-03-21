class CreateTypeComics < ActiveRecord::Migration
  def change
    create_table :type_comics do |t|
    	t.text :web_url
    	t.text :pic_1_url
    	t.text :pic_2_url
    	t.text :pic_3_url
    	t.text :pic_4_url
      t.timestamps null: false
    end
  end
end
