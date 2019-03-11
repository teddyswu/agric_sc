class CreateUserAnalyzes < ActiveRecord::Migration
  def change
    create_table :user_analyzes do |t|
    	t.integer :f_id
    	t.text	:origin
    	t.text	:send_to_module
    	t.text	:keyword
    	t.string	:gender
    	t.string	:age
    	t.string	:name

      t.timestamps null: false
    end
  end
end
