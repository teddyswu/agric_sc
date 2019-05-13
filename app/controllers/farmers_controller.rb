class FarmersController < ApplicationController

	def show
		@farmer = User.joins(:farmer_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		record_ids = WorkDiary.joins(:work_diary_images).where("work_diary_images.enabled = true and owner_id = #{params[:id]}").map {|rd| rd.id }
		@work_records = WorkDiary.where(:id => record_ids).order(diary_time: :desc).paginate(:page => params[:page], per_page: 6)
		@work_record_all = WorkDiary.where(:owner_id => params[:id]).order(diary_time: :desc)
		@is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
		set_page_description("友善小農-#{@farmer.farmer_profile.front_name}的農場日誌，有機農務的工作紀錄、農場生活發生的趣事和隨時紀錄的照片與影片。")
    set_page_image @farmer.farmer_profile.user_pic_url
    set_page_title "#{@farmer.farmer_profile.front_name}- #{@farmer.farmer_profile.farm_name}工作牆"
		render layout: "story"
	end

	def work_record
		@is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
		@farmer = User.find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_records = WorkRecord.where(:owner_id => params[:id])
		set_page_description("友善小農-#{@farmer.farmer_profile.front_name}的有機農場工作紀錄，即時且透明，小農從除草、施肥、耕作、採收到包裝的時程都可以快速查詢。")
    set_page_image @farmer.farmer_profile.user_pic_url
    set_page_title "#{@farmer.farmer_profile.front_name}- 有機農場工作紀錄"
		render layout: "story"
	end

	def page
		record_ids = WorkDiary.joins(:work_diary_images).where("work_diary_images.enabled = true and owner_id = #{params[:id]}").map {|rd| rd.id }
		wr = WorkDiary.where(:id => record_ids).order(diary_time: :desc)
		if params[:page].to_i < wr.size.div(6) + 2
			@is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
			@farmer = User.joins(:farmer_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
			@work_records = WorkDiary.where(:id => record_ids).order(diary_time: :desc).paginate(:page => params[:page], per_page: 6)	
			render :layout => "story" and return
		end
		render :nothing => true, :status => 404, :content_type => 'text/html'
	end

	def favo_farmers
		favo_farmer = FavoFarmer.where(:user_id => current_user.id, :farmer_id => params[:farmer_id])
		favo_farmer.present? ? favo_farmer.destroy_all : favo_farmer.create
		render plain: ""
	end

	def mobile_img
		@farmer = User.joins(:farmer_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		@work_diary = WorkDiary.find(params[:record_id])
		@mood = WorkDiaryMood.find_by(:work_diary_id => params[:record_id], :user_id => current_user.id) if user_signed_in?
		set_page_description "友善小農-#{@farmer.farmer_profile.front_name}的農場日誌紀錄。"
    set_page_image @work_diary.work_diary_images.first.cover_url
    set_page_title "#{@farmer.farmer_profile.front_name}: 「#{@work_diary.comment}」"
		render layout: "story"
	end
end
