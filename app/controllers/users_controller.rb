class UsersController < ApplicationController
	before_filter :authenticate_user!
	def profile
		@user = User.find(current_user.id)
		render layout: "story"
	end
	def create
	end
	def update
		user = UserProfile.find_by_user_id(current_user.id)
		user.update(user_profile_params)
		user.save

		redirect_to :action => :profile
	end

	def user_profile_params
		params.require(:user_profile).permit(:front_name, :gender, :birthday, :introduce)
	end
end
