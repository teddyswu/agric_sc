class WorkRecordRepliesController < ApplicationController
	before_filter :authenticate_user!

	def create
		@wrr = WorkRecordReply.new(work_record_reply_params)
		@wrr.save!
		@user = User.find(@wrr.user_id)
	end

	def work_record_reply_params
		params.require(:work_record_reply).permit(:content, :user_id, :work_record_id)
	end
end
