class AddColumnThreeMood < ActiveRecord::Migration
  def change
  	add_column :work_records, :smile, :integer, :after => :work_time
  	add_column :work_records, :general, :integer, :after => :smile
  	add_column :work_records, :dislike, :integer, :after => :general
  end
end
