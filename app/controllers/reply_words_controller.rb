class ReplyWordsController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:index]

  def index
  	@reply_words = ReplyWord.all.order(id: :desc).paginate(:page => params[:page], per_page: 10)
  	@effect_word = ReplyWord.where("start_time < ? and end_time > ? and enabled = true", Time.now, Time.now).size
  end

  def new
  	@reply_word = ReplyWord.new
  end

  def edit
  	@reply_word = ReplyWord.find(params[:id])
  end

  def create
    @reply_word = ReplyWord.new(reply_word_params)
    @reply_word.save!
    redirect_to :action => :index
  end

  def update
  	@reply_word = ReplyWord.find(params[:id])
  	@reply_word.update(reply_word_params)
    redirect_to :action => :index
  end

  def reply_word_params
    params[:reply_word]["end_time(1i)"] = "2999" if params[:datetimeStyle] == "forever"
		params.require(:reply_word).permit(:category, :show_name, :start_time, :end_time, :enabled)
	end
end
