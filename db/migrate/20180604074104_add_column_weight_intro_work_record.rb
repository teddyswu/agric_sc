class AddColumnWeightIntroWorkRecord < ActiveRecord::Migration
  def change
  	add_column :work_records , :weight, :float, :after => :record_type
  end
end
