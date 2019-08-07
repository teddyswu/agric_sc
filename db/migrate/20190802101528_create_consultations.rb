class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
    	t.string :name
    	t.integer :gender
    	t.integer :age_range

      t.timestamps null: false
    end
  end
end
