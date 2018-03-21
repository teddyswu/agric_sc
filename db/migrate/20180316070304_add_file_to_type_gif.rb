class AddFileToTypeGif < ActiveRecord::Migration
  def change
  	add_column :type_gifs, :file, :integer, :after => :url
  end
end
