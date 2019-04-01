class AddColumnEnabled < ActiveRecord::Migration
  def change
  	add_column :wordings, :enabled, :boolean, :after => :content
  	add_column :stories, :enabled, :boolean, :after => :easter_egg_url
  end
end
