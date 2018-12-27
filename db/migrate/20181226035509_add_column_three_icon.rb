class AddColumnThreeIcon < ActiveRecord::Migration
  def change
  	add_column :work_diaries, :smile, :integer, :after => :diary_time
  	add_column :work_diaries, :general, :integer, :after => :smile
  	add_column :work_diaries, :dislike, :integer, :after => :general
  	
  end
end
