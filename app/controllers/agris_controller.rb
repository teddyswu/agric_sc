class AgrisController < ApplicationController
	# before_action :is_admin, except: [:showgif, :showjpg]
  before_action :authenticate_user!, except: [:showgif, :showjpg]
	skip_before_action :verify_authenticity_token
  before_action :check_admin, except: [:showgif, :showjpg]

  caches_action :showgif, :cache_path => Proc.new {
    cache_path = "#{WebConf.host}-#{request.path}_showgif_cache"
  }, :expires_in => 24.hour

  caches_action :showjpg, :cache_path => Proc.new {
    cache_path = "#{WebConf.host}-#{request.path}_showjpg_cache"
  }, :expires_in => 24.hour


  def index
	end

  def user_list
    @users = UserSubscription.all.paginate(:page => params[:page], per_page: 10)
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
    else
      @wording_lists = Wording.all.order(id: :desc).paginate(:page => params[:page], per_page: 10)
    end
  end

  def wording_new
    @wording = Wording.new
    @cat = WordingCat.all
  end

  
  def wording_create
    @wording = Wording.new(word_params)
    @wording.enabled = true
    @wording.save!

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

    redirect_to :action => :wording_list
  end

  def word_params
    params.require(:wording).permit(:name, :content, :wording_cat_id)
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
end
