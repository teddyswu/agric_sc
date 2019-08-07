class AddTwoColumnIntoConsultation < ActiveRecord::Migration
  def change
  	remove_column :consultations, :gender
  	remove_column :consultations, :age_range
  end
end
