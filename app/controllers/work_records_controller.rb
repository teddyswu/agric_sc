class WorkRecordsController < ApplicationController
	def index
		@records = WorkRecord.all.paginate(:page => params[:page], per_page: 10)
	end
	def show
	end
end
