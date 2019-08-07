class AddSortIntoConsulation < ActiveRecord::Migration
  def change
  	add_column :consultation_cates, :sort, :integer, :after => :pic
  	add_column :consultation_options, :sort, :integer, :after => :content
  	remove_column :consultation_options, :content
  	remove_column :consultation_options, :intro
  	remove_column :consultation_options, :pic
  end
end
