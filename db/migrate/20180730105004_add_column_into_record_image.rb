class AddColumnIntoRecordImage < ActiveRecord::Migration
  def change
  	add_column :work_record_images, :cover_url, :text, :after => :url
  	add_column :work_record_images, :origin_url, :text, :after => :cover_url
  end
end
