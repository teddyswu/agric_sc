class AgrisController < ApplicationController
	before_action :authenticate_user!
	skip_before_action :verify_authenticity_token
  def index
	end
	def comic
		@type = FileList.new
    @type_comic = TypeComic.new
    @type_comic_ten = DigitalResourceShip.where(:resource_type => "TypeComic").order(id: :desc).limit(10)

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
    comic_ship.encryption = Digest::SHA256.hexdigest "id#{comic_ship.id}" 
    comic_ship.save!
    redirect_to :action => :comic
  end

	def comic_del
	end

  def movie
    @type = FileList.new
    @type_movie = TypeMovie.new
    @type_movie_ten = DigitalResourceShip.where(:resource_type => "TypeMovie").order(id: :desc).limit(10)
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
    movie_ship.encryption = Digest::SHA256.hexdigest "id#{movie_ship.id}" 
    movie_ship.save!
    redirect_to :action => :movie
  end

  def movie_del
    resource_ship =  DigitalResourceShip.find(params[:id])
    resource_ship.resource.destroy
    resource_ship.destroy
    redirect_to :action => :movie
  end

  def gif
  	@type = TypeGif.new
  	@type_gif_ten = DigitalResourceShip.where(:resource_type => "TypeGif").order(id: :desc).limit(10)
  end

  def gif_del
  	resource_ship =  DigitalResourceShip.find(params[:id])
  	resource_ship.resource.destroy
  	resource_ship.destroy
  	redirect_to :action => :gif
  end

  def article
    @type_article = TypeArticle.new
    @type_article_ten = DigitalResourceShip.where(:resource_type => "TypeArticle").order(id: :desc).limit(10)
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
    article_ship.encryption = Digest::SHA256.hexdigest "id#{article_ship.id}" 
    article_ship.save!
    redirect_to :action => :article

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
