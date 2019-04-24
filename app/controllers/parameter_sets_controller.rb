class ParameterSetsController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :join_projects]
  before_action :is_admin, only: [:index]

  def index
  	@parameters = ParameterSet.all
  end

  def new
    @wordings = Wording.where(:enabled => true)
  	@parameters = ParameterSet.new
  end

  def edit
    @wordings = Wording.where(:enabled => true)
  	@parameters = ParameterSet.find(params[:id])
  end

  def create
  	@parameters = ParameterSet.new(parameter_set_params)
    @parameters.enabled = true
    @parameters.save!
    if @parameters.cat == 2
      aj = Wording.find(@parameters.wording_id)
      analysis_json(aj.content, @parameters.id, "guest")
      analysis_json(aj.content, @parameters.id, "subscribe_guest")
      analysis_json(aj.content, @parameters.id, "user")
    else
      analysis_json(@parameters.guest, @parameters.id, "guest")
      analysis_json(@parameters.subscribe_guest, @parameters.id, "subscribe_guest")
      analysis_json(@parameters.user, @parameters.id, "user")
  	end
    redirect_to :action => :index
  end

  def update
  	@parameters = ParameterSet.find(params[:id])
  	@parameters.update(parameter_set_params)
    dd = ParameterJson.where(:parameter_set_id => @parameters.id)
    dd.destroy_all
    if @parameters.cat == 2
      aj = Wording.find(@parameters.wording_id)
      analysis_json(aj.content, @parameters.id, "guest")
      analysis_json(aj.content, @parameters.id, "subscribe_guest")
      analysis_json(aj.content, @parameters.id, "user")
    else
      analysis_json(@parameters.guest, @parameters.id, "guest")
      analysis_json(@parameters.subscribe_guest, @parameters.id, "subscribe_guest")
      analysis_json(@parameters.user, @parameters.id, "user")
    end
    redirect_to :action => :index
  end

  def destroy
  	mp = ParameterSet.find(params[:id])
  	mp.enabled = (mp.enabled == true ? false : true)
    mp.save!
  	redirect_to :action => :index
  end

  def analysis_json(content, id, type)
    ana = JSON.parse(content)
    aa = Array.new
    name = ""
    ana.each do |jj|
      name = jj[0]["NAME"] if name == ""
      aa << jj
      if jj[0]["quick_replies"].present? or jj[0]["buttons"].present?
        pj = ParameterJson.new
        pj.name = name
        pj.json = aa
        pj.parameter_set_id = id
        pj.parameter_set_type = type
        pj.save!
        name = ""
        aa = []
      end
    end
  end

  def parameter_set_params
		params.require(:parameter_set).permit(:name, :cat, :wording_id, :ref, :guest, :subscribe_guest, :user)
  end
end
