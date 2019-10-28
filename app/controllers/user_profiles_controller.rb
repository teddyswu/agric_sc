class UserProfilesController < ApplicationController
	def update
		@user_profile = FarmerProfile.find(params[:farmer_profile][:user_id])
    #@user_profile.user.email = params[:farmer_profile][:user_email]
    #@user_profile.user.save!
	  @user_profile.update(user_profile_params)
	  @farming_categories = UserFarmingCategoryShip.where(:user_id => params[:farmer_profile][:user_id])
    @farming_categories.destroy_all
    params[:farmer_profile][:category].each do |cate|
    	farm_cate = UserFarmingCategoryShip.new
    	farm_cate.user_id = params[:farmer_profile][:user_id]
    	farm_cate.farming_category_id = cate
    	farm_cate.save!
    end
    auth = Authorization.find_or_initialize_by(:provider => "facebook", :uid => params[:farmer_profile][:fb_uid], :user_id => params[:farmer_profile][:user_id])
    auth.save! if params[:farmer_profile][:fb_uid].present?
    if params[:filed_code].present?
      @filed_code = FiledCode.where(:user_id => params[:farmer_profile][:user_id])
      @filed_code.destroy_all
      params[:filed_code].each do |key,value|
        if value != ""
        	filed_code = FiledCode.new
        	filed_code.user_id = params[:farmer_profile][:user_id]
        	filed_code.filed_code_name = value
        	filed_code.save!
        end
      end
    end
		redirect_to edit_user_manage_path
	end

	def user_profile_params
		params.require(:farmer_profile).permit(:user_id, :verification_status, :fb_url, :fb_uid, :ps_group_id, :email, :farm_name, :ps_group, :name, :tel, :cell_phone, :address, :certification_body,:certificate_photo, :certificate_photo_2, :oc_num, :crop_name, :validity_period, :introduce, :user_pic_url, :front_name)
	end
end
