class ChangeWordingIdToWordingJsonId < ActiveRecord::Migration
  def change
  	rename_column :generic_jsons, :wording_id, :wording_json_id
  	rename_column :specify_jsons, :wording_id, :wording_json_id
  end
end
