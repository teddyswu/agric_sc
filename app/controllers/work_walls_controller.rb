class WorkWallsController < ApplicationController
	def index
		@big_head = WorkDiaryImage.where(:position => 1).order("updated_at DESC").limit(1)
		@small_rectangle = WorkDiaryImage.where(:position => 2).order("updated_at DESC").limit(8)
		@straight_bar = WorkDiaryImage.where(:position => 3).order("updated_at DESC").limit(3)
		@bar = WorkDiaryImage.where(:position => 4).order("updated_at DESC").limit(1)
		render layout: "story"
	end
end
