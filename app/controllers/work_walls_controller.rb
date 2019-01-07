class WorkWallsController < ApplicationController
	def index
		@big_head = WorkDiaryImage.where(:position => 1, :enabled => true).order("updated_at DESC").limit(1)
		@small_rectangle = WorkDiaryImage.where(:position => 2, :enabled => true).order("updated_at DESC").limit(8)
		@straight_bar = WorkDiaryImage.where(:position => 3, :enabled => true).order("updated_at DESC").limit(3)
		@bar = WorkDiaryImage.where(:position => 4, :enabled => true).order("updated_at DESC").limit(1)
		render layout: "story"
	end
end
