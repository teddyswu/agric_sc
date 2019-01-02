class AddColumnFilterAndPositionToWorkRecordImage < ActiveRecord::Migration
  def change
  	add_column :work_record_images, :filter, :string, :after => :enabled
  	add_column :work_record_images, :position, :integer, :after => :filter
  end
end
