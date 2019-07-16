class UserInputsController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:index]

  def index
  	@generic_keywords = GenericKeyword.all.to_a
  end

  def new
    @generic_keyword = GenericKeyword.new
    @wordings = Wording.where(:enabled => true).where.not(:wording_cat_id => nil)
  end

  def create
  	@generic_keyword = GenericKeyword.new(wording_params)
    @generic_keyword.save!
    generic_json = GenericJson.new()
    generic_json.generic_keyword_id = @generic_keyword.id
    generic_json.cat = params[:generic_json][:cat]
    generic_json.json = params[:generic_json][:json]
    generic_json.wording_json_id = params[:generic_json][:wording_json_id]
    generic_json.save!

    redirect_to user_inputs_path
  end

  def edit
  	@generic_keyword = GenericKeyword.find(params[:id])
    if @generic_keyword.generic_json.wording_json_id != 0
      @wording = WordingJson.find(@generic_keyword.generic_json.wording_json_id).wording_id
      @wording_jsons = WordingJson.where(:wording_id => @wording)
    else
      @wording = nil
      @wording_jsons = []
    end
    @wordings = Wording.where(:enabled => true).where.not(:wording_cat_id => nil)
    @keyword = Array.new
    @generic_keyword.keyword.split(",").each_with_index do |k, i|
      @keyword[i] = {"id" => k, "name" => k}
    end
  end

  def update
  	@generic_keyword = GenericKeyword.find(params[:id])
  	@generic_keyword.update(wording_params)

  	generic_json = GenericJson.find_by(:Generic_keyword_id => params[:id])
    generic_json.cat = params[:generic_json][:cat]
    generic_json.json = params[:generic_json][:json]
    generic_json.wording_json_id = params[:generic_json][:wording_json_id]
    generic_json.save!

    redirect_to user_inputs_path
  end

  def destroy
  	kw = GenericKeyword.find(params[:id])
    kw.destroy
    redirect_to user_inputs_path
  end

  def wording_params
    params.require(:generic_keyword).permit(:keyword_type, :keyword, generic_json_attributes:
      [:json, :cat, :wording_cat_id])
  end
end
