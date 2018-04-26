class UserManagesController < ApplicationController

	def index
		@users = User.all.paginate(:page => params[:page], per_page: 10)
		respond_to do |format|
      format.html
      format.pdf do
      	pdf = Prawn::Document.new
      	pdf.font"/Library/Fonts/Arial Unicode.ttf"
      	pdf.text "你好"
      	send_data pdf.render
      end
    end
	end

	def edit
		@user = User.find(params[:id])
		@default = @user.farming_categories.map {|farm| {:id => farm.id, :name => farm.name} }
		farms = FarmingCategory.all.map {|farm| {:id => farm.id, :name => farm.name} }
    @los_farms = farms - @default
	end
	def update
		@user = User.find(params[:id])
		@user.update(user_params)

		redirect_to :action => :index
	end

	def farmer
		@users = User.where(:is_farmer => true ).paginate(:page => params[:page], per_page: 10)
	end


	def user_params
		params.require(:user).permit(:is_admin, :is_check_farmer)
	end
end
