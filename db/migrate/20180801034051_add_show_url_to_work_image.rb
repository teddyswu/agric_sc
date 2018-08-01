class AddShowUrlToWorkImage < ActiveRecord::Migration
  def change
  	add_column :work_record_images, :show_url, :text, :after => :origin_url
  end
end
