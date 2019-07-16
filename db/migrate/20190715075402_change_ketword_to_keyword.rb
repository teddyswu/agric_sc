class ChangeKetwordToKeyword < ActiveRecord::Migration
  def change
  	rename_column :generic_keywords, :ketword, :keyword
  end
end
