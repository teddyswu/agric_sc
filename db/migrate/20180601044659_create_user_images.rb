class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
    	t.string :file
    	t.text	:url

      t.timestamps null: false
    end
  end
end
