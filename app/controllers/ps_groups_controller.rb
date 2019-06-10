class PsGroupsController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:index]

  def index
  	@ps_groups = PsGroup.all.order(id: :desc).paginate(:page => params[:page], per_page: 10)
  end

  def new
  	@ps_group = PsGroup.new
  end

  def create
  	ps_group = PsGroup.new(ps_group_params)
  	ps_group.enabled = true
  	ps_group.save!

  	redirect_to :action => :index
  end

  def update
  	ps_group = PsGroup.find(params[:id])
  	ps_group.update(ps_group_params)
  	redirect_to :action => :index
  end

  def edit
  	@ps_group = PsGroup.find(params[:id])

  end

  def destroy
  	ps_group = PsGroup.find(params[:id])
  	ps_group.enabled = (ps_group.enabled == true ? false : true)
    ps_group.save!
  	redirect_to :action => :index
  end

  def ps_group_params
  	params.require(:ps_group).permit(:name)
  end
end
