class WorkProjectsController < ApplicationController
	def index
		@work_projects = WorkProject.all.paginate(:page => params[:page], per_page: 10)
	end

	def new
		@work_project = WorkProject.new
	end

	def create
		work_project = WorkProject.new(work_project_params)
		work_project.save
		redirect_to :action => :index
	end

	def work_project_params
		params.require(:work_project).permit(:name, :record_type)
	end
end
