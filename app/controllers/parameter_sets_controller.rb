class ParameterSetsController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :join_projects]
  before_action :is_admin, only: [:index]

  def index
  	@parameters = ParameterSet.all.paginate(:page => params[:page], per_page: 10)
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

  def name_edit
    @parameter_json = ParameterJson.find(params[:id])
  end

  def name_update
    @parameter_json = ParameterJson.find(params[:id])
    @parameter_json.def_name = params[:parameter_json][:def_name]
    @parameter_json.save!

    redirect_to list_parameter_set_path(@parameter_json.parameter_set_id)
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

  def list
    @parameter_jsons = ParameterJson.where(:parameter_set_id => params[:id])
  end

  def set_list
    @wording_set = ParameterJson.find(params[:id])
    @specify_keywords = SpecifyKeyword.where(:resource_id => params[:id], :resource_type => "ParameterJson")
  end

  def set_new
    @wording_set = ParameterJson.find(params[:id])
    @specify_keyword = SpecifyKeyword.new
    @wordings = Wording.where(:enabled => true).where.not(:wording_cat_id => nil)
  end

  def set_edit
    @specify_keyword = SpecifyKeyword.find(params[:id])
    if @specify_keyword.specify_json.wording_json_id != 0
      @wording = WordingJson.find(@specify_keyword.specify_json.wording_json_id).wording_id
      @wording_jsons = WordingJson.where(:wording_id => @wording)
    else
      @wording = nil
      @wording_jsons = []
    end
    @wording_set = @specify_keyword.resource
    @wordings = Wording.where(:enabled => true).where.not(:wording_cat_id => nil)
    @keyword = Array.new
    @specify_keyword.keyword.split(",").each_with_index do |k, i|
      @keyword[i] = {"id" => k, "name" => k}
    end
  end

  def set_create
    @specify_keyword = SpecifyKeyword.new(wording_params)
    @specify_keyword.save!
    specify_json = SpecifyJson.new()
    specify_json.specify_keyword_id = @specify_keyword.id
    specify_json.cat = params[:specify_json][:cat]
    specify_json.json = params[:specify_json][:json]
    specify_json.wording_json_id = params[:specify_json][:wording_json_id]
    specify_json.save!

    redirect_to set_list_parameter_set_path(@specify_keyword.resource_id)
  end

  def set_update
    @specify_keyword = SpecifyKeyword.find(params[:id])
    @specify_keyword.update(wording_params)

    specify_json = SpecifyJson.find_by(:specify_keyword_id => params[:id])
    specify_json.cat = params[:specify_json][:cat]
    specify_json.json = params[:specify_json][:json]
    specify_json.wording_json_id = params[:specify_json][:wording_json_id]
    specify_json.save!

    redirect_to set_list_parameter_set_path(@specify_keyword.resource_id)
  end

  def set_delete
    kw = SpecifyKeyword.find(params[:id])
    d = kw.resource_id
    kw.destroy
    redirect_to set_list_parameter_set_path(d)
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

  private

  def parameter_set_params
		params.require(:parameter_set).permit(:name, :cat, :wording_id, :ref, :guest, :subscribe_guest, :user)
  end

  def wording_params
    params.require(:specify_keyword).permit(:resource_type, :resource_id, :pl_name, :role, :keyword_type, :keyword,
      specify_json_attributes:
      [:json, :cat, :wording_cat_id])
  end
end
