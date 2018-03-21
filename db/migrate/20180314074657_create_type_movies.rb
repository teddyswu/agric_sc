class CreateTypeMovies < ActiveRecord::Migration
  def change
    create_table :type_movies do |t|
    	t.text :pic_url
    	t.text :movie_url
    	t.text :description
      t.timestamps null: false
    end
  end
end
