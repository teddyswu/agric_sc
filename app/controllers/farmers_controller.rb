class FarmersController < ApplicationController

	def show
		@wrr = WorkRecordReply.new
		@farmer = User.joins(:user_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_records = WorkRecord.where(:owner_id => params[:id]).order(id: :desc).paginate(:page => params[:page], per_page: 6)
		@work_record_all = WorkRecord.where(:owner_id => params[:id]).order(id: :desc)
		render layout: "story"
	end

	def work_record
		@farmer = User.find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_records = WorkRecord.where(:owner_id => params[:id])
		render layout: "story"
	end
end
