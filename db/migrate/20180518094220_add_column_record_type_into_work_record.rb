class AddColumnRecordTypeIntoWorkRecord < ActiveRecord::Migration
  def change
  	add_column :work_records, :record_type, :integer, :after => :owner_id
  end
end
