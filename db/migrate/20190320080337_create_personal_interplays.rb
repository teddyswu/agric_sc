class CreatePersonalInterplays < ActiveRecord::Migration
  def change
    create_table :personal_interplays do |t|
    	t.string :qr_name
    	t.text	:start_model

      t.timestamps null: false
    end
  end
end
