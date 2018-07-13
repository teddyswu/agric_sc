class AddEnabledIntoWorkRecordImage < ActiveRecord::Migration
  def change
  	add_column :work_record_images, :enabled, :boolean, :after => :url
  end
end
