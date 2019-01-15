class FarmersController < ApplicationController

	def show
		@farmer = User.joins(:farmer_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		record_ids = WorkDiary.joins(:work_diary_images).where("work_diary_images.enabled = true and owner_id = #{params[:id]}").map {|rd| rd.id }
		@work_records = WorkDiary.where(:id => record_ids).order(diary_time: :desc).paginate(:page => params[:page], per_page: 6)
		@work_record_all = WorkDiary.where(:owner_id => params[:id]).order(diary_time: :desc)
		@is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
		render layout: "story"
	end

	def work_record
		@farmer = User.find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_records = WorkRecord.where(:owner_id => params[:id])
		render layout: "story"
	end

	def mobile_img
		@farmer = User.joins(:farmer_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_diary = WorkDiary.find(params[:record_id])
		@mood = WorkDiaryMood.find_by(:work_diary_id => params[:record_id], :user_id => current_user.id) if user_signed_in?
		render layout: "story"
	end
end
