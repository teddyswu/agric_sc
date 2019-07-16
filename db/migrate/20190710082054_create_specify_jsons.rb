class CreateSpecifyJsons < ActiveRecord::Migration
  def change
    create_table :specify_jsons do |t|
    	t.integer	:specify_keyword_id
    	t.text	:json
    	t.integer	:cat
    	t.integer	:wording_id

      t.timestamps null: false
    end
  end
end
