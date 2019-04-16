class AddTwoColumnIntoUserAnalyze < ActiveRecord::Migration
  def change
  	add_column :user_analyzes, :watermarks, :text, :after => :name
  	add_column :user_analyzes, :status, :text, :after => :watermarks
  end
end
