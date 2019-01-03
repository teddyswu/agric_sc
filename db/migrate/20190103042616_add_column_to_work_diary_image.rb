class AddColumnToWorkDiaryImage < ActiveRecord::Migration
  def change
  	add_column :work_diary_images, :filter, :string, :after => :enabled
  	add_column :work_diary_images, :position, :integer, :after => :filter
  	remove_column :work_record_images, :filter
  	remove_column :work_record_images, :position
  end
end
