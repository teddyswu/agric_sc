class UserManagesController < ApplicationController
	before_filter :authenticate_user!, only: [:farmer, :index]
  before_action :is_admin, only: [:farmer, :index]

	def index
		@users = User.all.order(id: :desc).paginate(:page => params[:page], per_page: 20)
	end

	def edit
		@users = FarmerProfileUserShip.where(:farmer_profile_id => params[:id])
		@farm = FarmerProfile.find(params[:id])
		@default = @farm.farming_categories.map {|farm| {:id => farm.id, :name => farm.name} }
		farms = FarmingCategory.all.map {|farm| {:id => farm.id, :name => farm.name} }
    @los_farms = farms - @default
    @filed_code = FiledCode.where(:user_id => params[:id])
    @ps_groups = PsGroup.normal_state.to_a
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		f = FarmerProfile.create(:user_id => params[:id])
		redirect_to :action => :index
	end

	def farm
		@users = FarmerProfile.all.paginate(:page => params[:page], per_page: 10)
		# @users = User.where(:is_farmer => true ).order(id: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def user
		@fu = FarmerProfileUserShip.new
		@farm = FarmerProfile.find(params[:id])
	end

	def post_user
		@fu = FarmerProfileUserShip.new(farmer_profile_user_ship_params)
		@fu.save!
    redirect_to edit_user_manage_path(@fu.farmer_profile_id)
	end

	def update_user
		@fu = FarmerProfileUserShip.find(params[:farmer_profile_user_ship][:id])
		@fu.update(farmer_profile_user_ship_params)

		redirect_to edit_user_manage_path(@fu.farmer_profile_id)
	end

	def edit_user
		@fu = FarmerProfileUserShip.find(params[:ship_id])
		@farm = FarmerProfile.find(params[:id])
	end

	def destroy
		@fu = FarmerProfile.find(params[:id])
		@fu.status = (@fu.status == true ? false : true)
		@fu.save!

		redirect_to farm_user_manages_path
	end


	def user_params
		params.require(:user).permit(:is_admin, :is_check_farmer, :is_farmer)
	end

	def farmer_profile_user_ship_params
		params.require(:farmer_profile_user_ship).permit(:farmer_profile_id, :user_id, :permission, :uid)
	end
end
