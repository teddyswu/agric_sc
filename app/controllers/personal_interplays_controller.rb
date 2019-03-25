class PersonalInterplaysController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :join_projects]
  before_action :is_admin, only: [:index]
  
  def index
  	@personal_inters = PersonalInterplay.all
  end

  def new
  	@personal_inter = PersonalInterplay.new
  end

  def edit
    @personal_inter = PersonalInterplay.find(params[:id])
  end

  def create
    @personal_inter = PersonalInterplay.new(personal_interplay_params)
    @personal_inter.save!
    redirect_to :action => :index
  end

  def update
    @personal_inter = PersonalInterplay.find(params[:id])
    @personal_inter.update(personal_interplay_params)
    redirect_to :action => :index
  end

  def destroy
    @personal_inter = PersonalInterplay.find(params[:id])
    @personal_inter.destroy

    redirect_to :action => :index
  end

  def personal_interplay_params
    params.require(:personal_interplay).permit(:qr_name, :start_model)
  end


end
