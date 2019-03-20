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
  end

  def create
  end

  def update
  end


end
