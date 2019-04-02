class CreateWordingCats < ActiveRecord::Migration
  def change
    create_table :wording_cats do |t|
    	t.string	:name
      t.timestamps null: false
    end
    rename_column :wordings, :cat, :wording_cat_id
  end
end
