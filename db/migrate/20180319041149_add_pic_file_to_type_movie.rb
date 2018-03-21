class AddPicFileToTypeMovie < ActiveRecord::Migration
  def change
  	add_column :type_movies, :pic_file, :string, :after => :pic_url
  end
end
