class CreateWordingJsons < ActiveRecord::Migration
  def change
    create_table :wording_jsons do |t|
    	t.string	:name
    	t.text	:json
    	t.integer	:wording_id

      t.timestamps null: false
    end
  end
end
