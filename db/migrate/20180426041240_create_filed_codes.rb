class CreateFiledCodes < ActiveRecord::Migration
  def change
    create_table :filed_codes do |t|
    	t.integer :user_id
    	t.string :filed_code_name

      t.timestamps null: false
    end
  end
end
