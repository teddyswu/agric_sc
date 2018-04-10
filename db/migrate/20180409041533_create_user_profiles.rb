class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
    	t.integer :user_id
    	t.string :fb_uid
    	t.text	:fb_url
    	t.string  :farm_name
    	t.string 	:name
    	t.string	:tel
    	t.string	:cell_phone
    	t.text	:address
    	t.text	:certification_body
    	t.string :category
    	t.string :crop_name
      t.text :certificate_photo
      t.datetime :validity_period
      t.timestamps null: false
    end
  end
end
