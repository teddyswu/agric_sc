class FarmingCategoriesController < ApplicationController
	def binding
		crop_selected_id = CategoryWorkShip.all.select(:farming_category_id)
    @crop = FarmingCategory.where.not(:id => crop_selected_id)
    @category_work_ship = CategoryWorkShip.new
    @work_projects = WorkProject.all.map {|work| {:id => work.id, :name => work.name} }
	end

	def create_binding
		params[:category_work_ship][:work_project_id].each do |work|
			ship = CategoryWorkShip.new
      ship.farming_category_id = params[:category_work_ship][:farming_category_id]
      ship.work_project_id = work
      ship.save!
		end
		redirect_to :action => :binding
	end

	def index
		@category_work_ship = CategoryWorkShip.all.paginate(:page => params[:page], per_page: 10)
	end
end
