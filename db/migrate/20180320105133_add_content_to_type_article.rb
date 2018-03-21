class AddContentToTypeArticle < ActiveRecord::Migration
  def change
  	add_column :type_articles, :content, :text, :after => :web_url
  end
end
