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
		set_page_title "友故事  |  FB 快速登入"
		ff = FbBinding.where(:scoped_id => params[:scoped_id])
		ff.destroy_all
		binding_ip = request.remote_ip + request.env["HTTP_USER_AGENT"]
		fb = FbBinding.create(:binding_ip => binding_ip, :scoped_id => params[:scoped_id], :module_name => params[:s])
	end

	def user_profile_params
		params.require(:farmer_profile).permit(:front_name, :gender, :birthday, :introduce)
	end
end
