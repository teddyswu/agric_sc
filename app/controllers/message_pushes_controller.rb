class MessagePushesController < ApplicationController
	before_filter :authenticate_user!
	def index
		# aa = PostMessageApiJob.set(wait: 5.seconds).perform_later
		# p aa.job_id
		@message_pushes = MessagePush.all.order(id: :DESC).paginate(:page => params[:page], per_page: 10)
	end

	def new
		@message_pushes = MessagePush.new
	end

	def create
		@message_pushes = MessagePush.new(message_push_params)
		pm = PostMessageApiJob.set(wait_until: @message_pushes.run_at).perform_later
		@message_pushes.delayed_job_id = pm.job_id
		@message_pushes.save!
    redirect_to :action => :index
	end

	def message_push_params
		params.require(:message_push).permit(:module_name, :user_list, :run_at)
  end
end
