class CreateGreetings < ActiveRecord::Migration
  def change
    create_table :greetings do |t|
    	t.string	:f_id
    	t.string	:name
    	t.text	:origin
    	t.boolean	:is_start_use
      t.timestamps null: false
    end
		change_column :user_analyzes, :f_id, :string
  end
end
