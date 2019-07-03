class AddThreeColumnIntoUserAnalyze < ActiveRecord::Migration
  def change
  	add_column :user_analyzes, :type, :string, :after => :name
  	add_column :user_analyzes, :url, :string, :after => :type
  	add_column :user_analyzes, :text, :string, :after => :url
  end
end
