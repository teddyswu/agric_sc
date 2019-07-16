class CreateSpecifyKeywords < ActiveRecord::Migration
  def change
    create_table :specify_keywords do |t|
    	t.string	:model_name
    	t.integer	:model_id
    	t.string	:pl_name
    	t.string	:role
    	t.integer	:type
    	t.text		:keyword

      t.timestamps null: false
    end
  end
end
