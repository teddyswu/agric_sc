class CreateConsultationOptions < ActiveRecord::Migration
  def change
    create_table :consultation_options do |t|
    	t.integer :consultation_cate_id
    	t.string	:name
    	t.text		:intro
    	t.text		:pic
    	t.text		:content

      t.timestamps null: false
    end
  end
end
