class ChangeTypeToKeywordType < ActiveRecord::Migration
  def change
  	rename_column :generic_keywords, :type, :keyword_type
  end
end
