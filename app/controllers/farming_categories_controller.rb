class FarmingCategoriesController < ApplicationController
	def binding
		@crop = FarmingCategory.all
    @category_work_ship = CategoryWorkShip.new
    selected_wp = CategoryWorkShip.select(:work_project_id).where(:farming_category_id => params[:category_id]) if params[:category_id].present?
    if params[:category_id].present?
    	@work_projects = WorkProject.where.not(:id => selected_wp).map {|work| {:id => work.id, :name => work.name} }
    	@default_projects = WorkProject.where(:id => selected_wp).map {|work| {:id => work.id, :name => work.name} }
    else
    	@work_projects = WorkProject.all.map {|work| {:id => work.id, :name => work.name} }
    	@default_projects = {}
    end
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
