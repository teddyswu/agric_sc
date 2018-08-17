class WorkDiariesController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:index]

	def index
		@diaries = WorkDiary.all.order(diary_time: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def record_img
    img = WorkDiaryImage.find(params[:id])
    img.enabled = (img.enabled == true ? false :true)
    img.save!

    redirect_to work_diaries_path  
  end
end
