class WorkProjectsController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:index]
	def index
		@work_projects = WorkProject.all.paginate(:page => params[:page], per_page: 10)
	end

	def new
		@work_project = WorkProject.new
	end

	def edit
		@select = [["農地耕作", "1"], ["採收後處理", "2"]]
		@work_project = WorkProject.find(params[:id])
	end

	def create
		work_project = WorkProject.new(work_project_params)
		work_project.save
		redirect_to :action => :index
	end

	def update
		@work_project = WorkProject.find(params[:id])
		@work_project.update(work_project_params)
		redirect_to :action => :index
	end

	def work_project_params
		params.require(:work_project).permit(:name, :record_type)
	end
end
