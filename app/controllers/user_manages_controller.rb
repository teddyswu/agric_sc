class UserManagesController < ApplicationController
	before_filter :authenticate_user!, only: [:farmer, :index]
  before_action :is_admin, only: [:farmer, :index]

	def index
		@users = User.all.order(id: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def edit
		@user = User.find(params[:id])
		@default = @user.farming_categories.map {|farm| {:id => farm.id, :name => farm.name} }
		farms = FarmingCategory.all.map {|farm| {:id => farm.id, :name => farm.name} }
    @los_farms = farms - @default
    @filed_code = FiledCode.where(:user_id => params[:id])
    @ps_groups = PsGroup.normal_state.to_a
	end
	def update
		@user = User.find(params[:id])
		@user.update(user_params)

		redirect_to :action => :index
	end

	def farmer
		@users = User.where(:is_farmer => true ).order(id: :desc).paginate(:page => params[:page], per_page: 10)
	end


	def user_params
		params.require(:user).permit(:is_admin, :is_check_farmer, :is_farmer)
	end
end
