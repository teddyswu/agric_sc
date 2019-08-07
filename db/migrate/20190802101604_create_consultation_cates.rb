class CreateConsultationCates < ActiveRecord::Migration
  def change
    create_table :consultation_cates do |t|
    	t.integer :consultation_id
    	t.string	:name
    	t.text		:intro
    	t.text		:pic

      t.timestamps null: false
    end
  end
end
