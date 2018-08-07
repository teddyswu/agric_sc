class AddShowUrlIntorFb < ActiveRecord::Migration
  def change
  	add_column :fb_to_aws, :show_url, :text, :after => :origin_url
  end
end
