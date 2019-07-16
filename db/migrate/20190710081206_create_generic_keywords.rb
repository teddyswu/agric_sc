class CreateGenericKeywords < ActiveRecord::Migration
  def change
    create_table :generic_keywords do |t|
    	t.text	:ketword
    	t.integer	:type

      t.timestamps null: false
    end
  end
end
