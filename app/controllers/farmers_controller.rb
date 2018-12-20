class FarmersController < ApplicationController

	def show
		# @wrr = WorkRecordReply.new
		@farmer = User.joins(:farmer_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		record_ids = WorkDiary.joins(:work_diary_images).where("work_diary_images.enabled = true and owner_id = #{params[:id]}").map {|rd| rd.id }
		@work_records = WorkDiary.where(:id => record_ids).order(diary_time: :desc).paginate(:page => params[:page], per_page: 6)
		@work_record_all = WorkDiary.where(:owner_id => params[:id]).order(diary_time: :desc)
		render layout: "story"
	end

	def work_record
		@farmer = User.find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_records = WorkRecord.where(:owner_id => params[:id])
		render layout: "story"
	end

	def mobile_img
	end
end
