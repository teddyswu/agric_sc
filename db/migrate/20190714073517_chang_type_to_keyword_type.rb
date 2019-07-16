class ChangTypeToKeywordType < ActiveRecord::Migration
  def change
  	rename_column :specify_keywords, :type, :keyword_type
  end
end
