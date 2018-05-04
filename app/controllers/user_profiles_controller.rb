class UserProfilesController < ApplicationController
	def update
		@user_profile = UserProfile.find_by_user_id(params[:user_profile][:user_id])
	  @user_profile.update(user_profile_params)
	  @farming_categories = UserFarmingCategoryShip.where(:user_id => params[:user_profile][:user_id])
    @farming_categories.destroy_all
    params[:user_profile][:category].each do |cate|
    	farm_cate = UserFarmingCategoryShip.new
    	farm_cate.user_id = params[:user_profile][:user_id]
    	farm_cate.farming_category_id = cate
    	farm_cate.save!
    end
    if params[:filed_code].present?
      params[:filed_code].split('_').each do |code|
      	filed_code = FiledCode.new
      	filed_code.user_id = params[:user_profile][:user_id]
      	filed_code.filed_code_name = code
      	filed_code.save!
      end
    end
		redirect_to edit_user_manage_path
	end

	def user_profile_params
		params.require(:user_profile).permit(:user_id, :fb_url, :farm_name, :ps_group, :name, :tel, :cell_phone, :address, :certification_body,:certificate_photo, :certificate_photo_2, :oc_num, :crop_name, :validity_period)
	end
end