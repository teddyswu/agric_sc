class ChangeColumnWorkProjectsIdToWorkProjectId < ActiveRecord::Migration
  def change
  	rename_column :category_work_ships, :work_projects_id, :work_project_id
  end
end
