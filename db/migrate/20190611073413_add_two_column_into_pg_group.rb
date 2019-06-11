class AddTwoColumnIntoPgGroup < ActiveRecord::Migration
  def change
  	add_column :ps_groups, :image_url, :string, :after => :name
  	add_column :ps_groups, :subtitle, :string, :after => :image_url
  end
end
