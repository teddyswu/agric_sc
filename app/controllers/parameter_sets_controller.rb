class ParameterSetsController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :join_projects]
  before_action :is_admin, only: [:index]

  def index
  	@parameters = ParameterSet.all
  end

  def new
  	@parameters = ParameterSet.new
  end

  def edit
  	@parameters = ParameterSet.find(params[:id])
  end

  def create
  	@parameters = ParameterSet.new(parameter_set_params)
    @parameters.enabled = true
    @parameters.save!
  	redirect_to :action => :index
  end

  def update
  	@parameters = ParameterSet.find(params[:id])
  	@parameters.update(parameter_set_params)
    redirect_to :action => :index
  end

  def destroy
  	mp = ParameterSet.find(params[:id])
  	mp.enabled = (mp.enabled == true ? false : true)
    mp.save!
  	redirect_to :action => :index
  end

  def parameter_set_params
		params.require(:parameter_set).permit(:ref, :guest, :subscribe_guest, :user)
  end
end
