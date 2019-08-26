class AddTwoColumnIntoCons < ActiveRecord::Migration
  def change
  	add_column :consultations, :type, :integer, :after => :name
  	add_column :consultations, :json,	:text, :after => :type
  end
end
