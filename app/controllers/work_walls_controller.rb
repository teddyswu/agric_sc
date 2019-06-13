class WorkWallsController < ApplicationController
	def index
		@big_head = WorkDiaryImage.where(:position => 1, :enabled => true).order("updated_at DESC").limit(1)
		@small_rectangle = WorkDiaryImage.where(:position => 2, :enabled => true).order("updated_at DESC").limit(8)
		@straight_bar = WorkDiaryImage.where(:position => 3, :enabled => true).order("updated_at DESC").limit(3)
		@bar = WorkDiaryImage.where(:position => 4, :enabled => true).order("updated_at DESC").limit(1)
		@is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
		set_page_description("友故事有機友善小農的工作牆拼圖，集合小農們有機農務的工作紀錄、農場生活發生的趣事和隨時紀錄的照片與影片。")
    set_page_image "https://www.ugooz.cc/assets/sk2/img/ui/logo.png"
    set_page_title "友善小農工作牆"
		render layout: "story"
	end

	def page
		# images = WorkDiaryImage.where(:enabled => true).where.not(:position => nil).paginate(:page => params[:page], per_page: 13)
		@big_head = WorkDiaryImage.where(:position => 1, :enabled => true).order("updated_at DESC").paginate(:page => params[:page], per_page: 1)
		@small_rectangle = WorkDiaryImage.where(:position => 2, :enabled => true).order("updated_at DESC").paginate(:page => params[:page], per_page: 8)
		@straight_bar = WorkDiaryImage.where(:position => 3, :enabled => true).order("updated_at DESC").paginate(:page => params[:page], per_page: 3)
		@bar = WorkDiaryImage.where(:position => 4, :enabled => true).order("updated_at DESC").paginate(:page => params[:page], per_page: 1)
		@is_favo = current_user.present? ? FavoFarmer.where(:user_id => current_user.id).map { |user| user.farmer_id } : [0]
		render layout: "story"
	end
end
