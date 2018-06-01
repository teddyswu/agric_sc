class UserProfilesController < ApplicationController
	def update
		@user_profile = UserProfile.find_by_user_id(params[:user_profile][:user_id])
    @user_profile.user.email = params[:user_profile][:user_email]
    @user_profile.user.save!
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
      @filed_code = FiledCode.where(:user_id => params[:user_profile][:user_id])
      @filed_code.destroy_all
      params[:filed_code].each do |key,value|
        if value != ""
        	filed_code = FiledCode.new
        	filed_code.user_id = params[:user_profile][:user_id]
        	filed_code.filed_code_name = value
        	filed_code.save!
        end
      end
    end
		redirect_to edit_user_manage_path
	end

	def user_profile_params
		params.require(:user_profile).permit(:user_id, :fb_url, :farm_name, :ps_group, :name, :tel, :cell_phone, :address, :certification_body,:certificate_photo, :certificate_photo_2, :oc_num, :crop_name, :validity_period, :introduce, :user_pic_url)
	end
end
