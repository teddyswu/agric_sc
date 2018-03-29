class UserManagesController < ApplicationController

	def index
		@users = User.all.paginate(:page => params[:page], per_page: 10)
	end

	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		@user.update(user_params)

		redirect_to :action => :index
	end


	def user_params
		params.require(:user).permit(:is_admin, :is_check_farmer)
	end
end
