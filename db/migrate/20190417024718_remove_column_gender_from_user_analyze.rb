class RemoveColumnGenderFromUserAnalyze < ActiveRecord::Migration
  def change
  	remove_column :user_analyzes, :gender
  end
end
