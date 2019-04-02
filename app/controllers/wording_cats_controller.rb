class WordingCatsController < ApplicationController
	def index
		@wording_cats = WordingCat.all.paginate(:page => params[:page], per_page: 10)
	end

	def new
		@wording_cat = WordingCat.new
	end

	def edit
		@wording_cat = WordingCat.find(params[:id])
	end

	def update
		@wording_cat = WordingCat.find(params[:id])
		@wording_cat.update(wording_cat_params)

		redirect_to :action => :index
	end

	def create
		wording_cat = WordingCat.new(wording_cat_params)
    wording_cat.save!

    redirect_to :action => :index
	end

	def wording_cat_params
		params.require(:wording_cat).permit(:name)
	end
end
