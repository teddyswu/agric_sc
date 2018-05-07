class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [:show]

	def index
		@story = Story.order(id: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def new
		@story = Story.new

	end

	def show
		@story = Story.find(params[:id])
		render layout: "story"
	end

	def destroy
	  @story = Story.find(params[:id])
	  @story.destroy

	  redirect_to :action => :new
	end

	def edit
		@story = Story.find(params[:id])
	end

	def update
		@story = Story.find(params[:id])
	  @story.update(story_params)

	  redirect_to :action => :index
	end

	def create
		@story = Story.new(story_params)
		@story.save!

		redirect_to :action => :new
	end


	def story_params
		params.require(:story).permit(:title, :content, :owner)
  end
end
