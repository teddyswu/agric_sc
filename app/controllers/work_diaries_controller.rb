class WorkDiariesController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:index]

	def index
		@diaries = WorkDiary.all.order(diary_time: :desc).paginate(:page => params[:page], per_page: 10)
	end

  def edit
    @diary = WorkDiaryImage.find(params[:id])
  end

  def update
    @diary = WorkDiaryImage.find(params[:id])
    @diary.update(dairy_params)

    redirect_to :action => :index
  end

	def record_img
    img = WorkDiaryImage.find(params[:id])
    img.enabled = (img.enabled == true ? false :true)
    img.save!

    redirect_to work_diaries_path  
  end

  def dairy_params
    params.require(:work_diary_image).permit(:enabled, :position, :filter)
  end

end
