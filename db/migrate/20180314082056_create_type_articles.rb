class CreateTypeArticles < ActiveRecord::Migration
  def change
    create_table :type_articles do |t|
    	t.text :web_url
    	t.text :description
      t.timestamps null: false
    end
  end
end
