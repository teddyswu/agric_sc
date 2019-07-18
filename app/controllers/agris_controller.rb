class AgrisController < ApplicationController
	# before_action :is_admin, except: [:showgif, :showjpg]
  before_action :authenticate_user!, except: [:showgif, :showjpg, :showpng]
	skip_before_action :verify_authenticity_token
  before_action :check_admin, except: [:showgif, :showjpg, :showpng]

  caches_action :showgif, :cache_path => Proc.new {
    cache_path = "#{WebConf.host}-#{request.path}_showgif_cache"
  }, :expires_in => 24.hour

  caches_action :showjpg, :cache_path => Proc.new {
    cache_path = "#{WebConf.host}-#{request.path}_showjpg_cache"
  }, :expires_in => 24.hour

  caches_action :showpng, :cache_path => Proc.new {
    cache_path = "#{WebConf.host}-#{request.path}_showgif_cache"
  }, :expires_in => 24.hour

  caches_action :user_list_alert, :cache_path => Proc.new {
    cache_path = "#{WebConf.host}-#{request.path}-#{params[:uid]}_user_list_alert_cache"
  }, :expires_in => 1.hour


  def index
    @talk_user = UserAnalyze.group(:uid).count
	end

  def user_list
    @total_user = UserAnalyze.group("uid").to_a
    @users = UserAnalyze.group("uid").order(id: :desc).paginate(:page => params[:page], per_page: 20)
  end

  def user_list_alert
    @user = UserAnalyze.where(:uid => params[:uid]).group("uid")
    @user_ref = UserAnalyze.where(:uid => params[:uid]).where.not(:ref => nil).order(created_at: :desc)
    @user_last_time = UserAnalyze.where(:uid => params[:uid]).order(created_at: :asc)
    render :layout => false
  end

  def user_list_search
    @total_user = UserAnalyze.group("uid").to_a
    @users = UserAnalyze.where("name like ?", "%#{params[:post][:name]}%").group("uid").order(id: :desc).paginate(:page => params[:page], per_page: 20)
  end

	def comic
		@type = FileList.new
    @type_comic = TypeComic.new
    @type_comics = DigitalResourceShip.where(:resource_type => "TypeComic").order(id: :desc).paginate(:page => params[:page], per_page: 10)

	end

  def comic_create
    type_comic = TypeComic.new(comic_params)
    type_comic.save!
    comic_ship = DigitalResourceShip.new
    comic_ship.resource_type = "TypeComic"
    comic_ship.resource_id = type_comic.id
    comic_ship.title = params[:title]
    comic_ship.encryption = "ss"
    comic_ship.save!
    redirect_to :action => :comic
  end

	def comic_del
	end

  def movie
    @type = FileList.new
    @type_movie = TypeMovie.new
    @type_movies = DigitalResourceShip.where(:resource_type => "TypeMovie").order(id: :desc).paginate(:page => params[:page], per_page: 10)
  end

  def movie_create
    type_movie = TypeMovie.new(movie_params)
    type_movie.save!
    movie_ship = DigitalResourceShip.new
    movie_ship.resource_type = "TypeMovie"
    movie_ship.resource_id = type_movie.id
    movie_ship.title = params[:title]
    movie_ship.encryption = "ss"
    movie_ship.save!
    redirect_to :action => :movie
  end

  def movie_del
    resource_ship =  DigitalResourceShip.find(params[:id])
    resource_ship.resource.destroy
    resource_ship.destroy
    redirect_to :action => :movie
  end

  def wording_list
    if params[:type].present?
      type = params[:type].upcase
      @wording_lists = Wording.where("name like '%#{type}%'").order(:name)
      @wording_cats = WordingCat.all
    else
      if params[:s].present?
        @wording_lists = Wording.where(:wording_cat_id => params[:s]).order(:name).paginate(:page => params[:page], per_page: 10)
        @wording_cats = WordingCat.all
      else
        @wording_lists = Wording.all.order(id: :desc).paginate(:page => params[:page], per_page: 10)
        @wording_cats = WordingCat.all  
      end
      
    end
  end

  def wording_json
    @wording_jsons = WordingJson.where(:wording_id => params[:id])
  end

  def wording_json_edit
    @wording_jsons = WordingJson.find(params[:id])
  end

  def wording_json_update
    @wording_jsons = WordingJson.find(params[:id])
    @wording_jsons.def_name = params[:wording_json][:def_name]
    @wording_jsons.save!

    redirect_to wording_json_path(@wording_jsons.wording_id)
  end

  def wording_set_list
    @wording_set = WordingJson.find(params[:id])
    @specify_keywords = SpecifyKeyword.where(:resource_id => params[:id], :resource_type => "WordingJson")
  end

  def wording_set_new
    @wording_set = WordingJson.find(params[:id])
    @specify_keyword = SpecifyKeyword.new
    @wordings = Wording.where(:enabled => true).where.not(:wording_cat_id => nil)
  end

  def wording_set_create
    @specify_keyword = SpecifyKeyword.new(wording_params)
    @specify_keyword.save!
    specify_json = SpecifyJson.new()
    specify_json.specify_keyword_id = @specify_keyword.id
    specify_json.cat = params[:specify_json][:cat]
    specify_json.json = params[:specify_json][:json]
    specify_json.wording_json_id = params[:specify_json][:wording_json_id]
    specify_json.save!

    redirect_to wording_set_list_path(@specify_keyword.resource_id)
  end

  def wording_set_edit
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

  def wording_set_update
    @specify_keyword = SpecifyKeyword.find(params[:id])
    @specify_keyword.update(wording_params)

    specify_json = SpecifyJson.find_by(:specify_keyword_id => params[:id])
    specify_json.cat = params[:specify_json][:cat]
    specify_json.json = params[:specify_json][:json]
    specify_json.wording_json_id = params[:specify_json][:wording_json_id].to_i
    specify_json.save!

    redirect_to wording_set_list_path(@specify_keyword.resource_id)

  end

  def wording_set_delete
    kw = SpecifyKeyword.find(params[:id])
    d = kw.resource_id
    kw.destroy
    redirect_to wording_set_list_path(d)
  end


  def wording_new
    @wording = Wording.new
    @cat = WordingCat.all
  end

  
  def wording_create
    @wording = Wording.new(word_params)
    @wording.enabled = true
    @wording.save!

    analysis_json(@wording.content, @wording.id)

    redirect_to :action => :wording_list
  end

  def wording_edit
    @wording = Wording.find(params[:id])
    @cat = WordingCat.all
  end

  def wording_delete
    @wording = Wording.find(params[:id])
    @wording.enabled = (@wording.enabled == true ? false : true)
    @wording.save!

    redirect_to :action => :wording_list
  end

  def wording_update
    @wording = Wording.find(params[:id])
    @wording.update(word_params)
    dd = WordingJson.where(:wording_id => @wording.id)
    dd.destroy_all
    analysis_json(@wording.content, @wording.id)

    redirect_to :action => :wording_list
  end

  def word_params
    params.require(:wording).permit(:name, :content, :wording_cat_id)
  end

  def analysis_json(content, id)
    ana = JSON.parse(content)
    aa = Array.new
    name = ""
    ana.each do |jj|
      name = jj[0]["NAME"] if name == ""
      aa << jj
      if jj[0]["quick_replies"].present? or jj[0]["buttons"].present?
        pj = WordingJson.new
        pj.name = name
        pj.json = aa
        pj.wording_id = id
        pj.save!
        name = ""
        aa = []
      end
    end
  end

  def gif
  	@type = TypeGif.new
  	@type_gifs = DigitalResourceShip.where(:resource_type => "TypeGif").order(id: :desc).paginate(:page => params[:page], per_page: 10)
  end

  def gif_edit
    @type_gif = DigitalResourceShip.find(params[:id])
  end

  def showgif
    domain = "https://soginationaltest.s3-ap-southeast-1.amazonaws.com/agric_sc/gif/"
    filename = params[:id]
    path = domain + filename + ".gif"
    data = open(path)
    send_data data.read, type: data.content_type, disposition: 'inline'
  end

  def showjpg
    domain = "https://soginationaltest.s3-ap-southeast-1.amazonaws.com/agric_sc/gif/"
    filename = params[:id]
    path = domain + filename + ".jpg"
    data = open(path)
    send_data data.read, type: data.content_type, disposition: 'inline'
  end

  def showpng
    domain = "https://soginationaltest.s3-ap-southeast-1.amazonaws.com/agric_sc/gif/"
    filename = params[:id]
    path = domain + filename + ".png"
    data = open(path)
    send_data data.read, type: data.content_type, disposition: 'inline'
  end

  def gif_del
  	resource_ship =  DigitalResourceShip.find(params[:id])
  	resource_ship.resource.destroy
  	resource_ship.destroy
  	redirect_to :action => :gif
  end

  def article
    @type_article = TypeArticle.new
    @type_articles = DigitalResourceShip.where(:resource_type => "TypeArticle").order(id: :desc).paginate(:page => params[:page], per_page: 10)
  end

  def article_create
    type_article = TypeArticle.new(article_params)
    type_article.save!
    article_ship = DigitalResourceShip.new
    article_ship.resource_type = "TypeArticle"
    article_ship.resource_id = type_article.id
    article_ship.title = params[:title]
    article_ship.encryption = "ss"
    article_ship.save!
    redirect_to :action => :article

  end

  def check_admin
    redirect_to root_path if current_user.is_admin != true
  end

  def movie_params
    params.require(:type_movie).permit(:description, :movie_url, :pic_url)
  end
  def comic_params
    params.require(:type_comic).permit(:pic_1_url, :pic_2_url, :pic_3_url, :pic_4_url, :web_url)
  end
  def article_params
    params.require(:type_article).permit(:content, :web_url, :description)
  end
  def wording_params
    params.require(:specify_keyword).permit(:resource_type, :resource_id, :pl_name, :keyword_type, :keyword,
      specify_json_attributes:
      [:json, :cat, :wording_cat_id])
  end
end
