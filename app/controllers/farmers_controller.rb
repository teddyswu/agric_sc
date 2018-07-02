class FarmersController < ApplicationController

	def show
		@farmer = User.joins(:user_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		render layout: "story"
	end

	def work_record
		@farmer = User.joins(:user_profile).find_by_id_and_is_farmer_and_is_check_farmer(params[:id], true ,true)
		render layout: "story"
	end
end
