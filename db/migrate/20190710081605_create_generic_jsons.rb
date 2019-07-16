class CreateGenericJsons < ActiveRecord::Migration
  def change
    create_table :generic_jsons do |t|
    	t.integer	:generic_keyword_id
    	t.text	:json
    	t.integer	:cat
    	t.integer	:wording_id

      t.timestamps null: false
    end
  end
end
