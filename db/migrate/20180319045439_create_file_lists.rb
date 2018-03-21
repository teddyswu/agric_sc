class CreateFileLists < ActiveRecord::Migration
  def change
    create_table :file_lists do |t|
    	t.string :file
    	t.text :url

      t.timestamps null: false
    end
    remove_column :type_movies, :pic_file
    remove_column :type_movies, :file
  end
end
