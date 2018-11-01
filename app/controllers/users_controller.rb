class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:fb_binding]
	def profile
		@user = User.find(current_user.id)
		render layout: "story"
	end
	def create
	end
	def update
		user = FarmerProfile.find_by_user_id(current_user.id)
		user.update(user_profile_params)
		user.save

		redirect_to :action => :profile
	end

	def fb_binding
		binding_ip = request.remote_ip
		fb = FbBinding.create(:binding_ip => binding_ip)
	end

	def user_profile_params
		params.require(:farmer_profile).permit(:front_name, :gender, :birthday, :introduce)
	end
end
