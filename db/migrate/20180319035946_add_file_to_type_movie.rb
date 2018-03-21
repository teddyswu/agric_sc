class AddFileToTypeMovie < ActiveRecord::Migration
  def change
  	add_column :type_movies, :file, :string, :after => :movie_url
  	change_column :type_gifs, :file, :string
  end
end
