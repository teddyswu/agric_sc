class CreateConsultationContents < ActiveRecord::Migration
  def change
    create_table :consultation_contents do |t|
    	t.integer	:consultation_option_id
    	t.integer	:gender
    	t.integer	:age_range
    	t.text	:intro
    	t.text	:pic
    	t.text	:content

      t.timestamps null: false
    end
  end
end
