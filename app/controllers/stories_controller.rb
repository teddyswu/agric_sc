class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [:show, :list]
	before_action :is_admin, except: [:show, :list]

	def index
		@story = Story.order(id: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def new
		@story = Story.new
		@story_tags = StoryTag.all
		@story_cat = StoryCat.all
	end

	def list
		@cats = StoryCat.all
		@tag = params[:tag].present? ? StoryTag.find(params[:tag]).name : "全部"
		if params[:tag].present? or params[:cat].present?
			if params[:tag].present?
				story_ids = StoryTagShip.where(:story_tag_id => params[:tag]).map {|story| story.story_id }
				@first_story = Story.where(:id => story_ids, :enabled => true).order(id: :desc).first
				@storys = Story.includes(:story_image, :story_tags).where(:id => story_ids, :enabled => true).where.not(:id => @first_story.id).order(id: :desc).paginate(:page => params[:page], per_page: 9)
			end
			if params[:cat].present?
				cat = params[:cat]
				@first_story = Story.where(:story_cat_id => cat, :enabled => true).order(id: :desc).first
				@storys = Story.includes(:story_image, :story_tags).where(:story_cat_id => cat, :enabled => true).where.not(:id => @first_story.id).order(id: :desc).paginate(:page => params[:page], per_page: 9)
			end
		else
			@first_story = Story.where(:enabled => true).order(id: :desc).first
			@storys = Story.includes(:story_image, :story_tags).where.not(:id => @first_story.id).order(id: :desc).paginate(:page => params[:page], per_page: 9)
		end
		set_page_description("提供有機農業、茶、茶葉知識，和在地農村故事、地方景點懶人包。")
    set_page_image("https://www.ugooz.cc/assets/sk2/img/ui/logo.png")
    set_page_title "有機知識與地方故事"
		render layout: "story"
	end

	def show
		@story = Story.find(params[:id])
		@recommend_story = Story.where.not(:id => params[:id] ).order(id: :desc).limit(3)
		set_page_description ActionView::Base.full_sanitizer.sanitize(@story.content)[0,120]
    set_page_image @story.story_image.url_cover
    set_page_title @story.title
		render layout: "story"
	end

	def destroy
	  @story = Story.find(params[:id])
	  @story.enabled = (@story.enabled == true ? false : true)
    @story.save!

	  redirect_to :action => :index
	end

	def edit
		@story = Story.find(params[:id])
		@story_tags = StoryTag.all
		@story_tag_ship = StoryTagShip.where(:story_id => params[:id]).map {|sts| sts.story_tag_id }
		@is_headline = Headline.exists?(:resource_type => "Story", :resource_id => params[:id])
		@story_cat = StoryCat.all
	end

	def update
		@story = Story.find(params[:id])
	  @story.update(story_params)
	  if story_img_params.present?
	  	@story_image = StoryImage.find_or_initialize_by(:story_id => params[:id])
	  	@story_image.update(story_img_params)
	  	@story_image.save!
	  	@story_image.update_urls_success?
	  end
	  @story_tag_ship = StoryTagShip.where(:story_id => params[:id])
	  @story_tag_ship.destroy_all
	  story_tag_params.each do |tap|
			@story_tag_ship = StoryTagShip.new
			@story_tag_ship.story_id = @story.id
			@story_tag_ship.story_tag_id = tap
			@story_tag_ship.save!
		end
		if params[:headerline] == "true" 
			Headline.find_or_create_by(:resource_type => "Story", :resource_id => @story.id) 
		else
			Headline.find_by(:resource_type => "Story", :resource_id => @story.id).destroy if Headline.exists?(:resource_type => "Story", :resource_id => @story.id)
		end
	  
	  redirect_to :action => :index
	end

	def create
		@story = Story.new(story_params)
		@story.save!
		@story_image = StoryImage.new(story_img_params)
		@story_image.story_id = @story.id
		@story_image.save!
		@story_image.update_urls_success?
		story_tag_params.each do |tap|
			@story_tag_ship = StoryTagShip.new
			@story_tag_ship.story_id = @story.id
			@story_tag_ship.story_tag_id = tap
			@story_tag_ship.save!
		end
		if params[:headerline] == true
			headerline_story = Headerline.find_or_create_by(:resource_type => "Story", :resource_id => @story.id)
		end

		redirect_to :action => :index
	end


	def story_params
		params.require(:story).permit(:title, :content, :owner, :story_cat_id, :easter_egg_url, :easter_egg_name)
  end

  def story_img_params
  	params.require(:story).permit(:file)
  end

  def story_tag_params
  	params.require(:tag_ids)
  end

end
