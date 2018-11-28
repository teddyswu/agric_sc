class MessagePushesController < ApplicationController
	before_filter :authenticate_user!
	def index
		# aa = PostMessageApiJob.set(wait: 5.seconds).perform_later
		# p aa.job_id
		@message_pushes = MessagePush.all.order(id: :DESC).paginate(:page => params[:page], per_page: 10)
	end

	def new
	end
end
