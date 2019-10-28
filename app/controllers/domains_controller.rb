class DomainsController < ApplicationController
	before_action :check_admin

	def index
		@domain = Domain.first
	end

	def new
		@domain = Domain.new
	end

	def create
		@domain = Domain.new
		if params[:domain]["def_week(1)"].present?
			week = Array.new
			week << params[:domain]["def_week(7)"]
			(1..6).each do |i|
				week << params[:domain]["def_week(#{i})"]
			end
			@domain.def_week = week
			@domain.save!
		else
			season = Array.new
			season << ""
			(1..12).each do |i|
				season << params[:domain]["def_season(#{i})"]
			end
			@domain.def_season = season
			@domain.save!
		end
		redirect_to :action => :index
	end

	def edit
		@domain = Domain.first
		@season = JSON.parse @domain.def_season
		@week = JSON.parse @domain.def_week
	end

	def update
		@domain = Domain.find(params[:id])
		if params[:domain]["def_week(1)"].present?
			week = Array.new
			week << params[:domain]["def_week(7)"]
			(1..6).each do |i|
				week << params[:domain]["def_week(#{i})"]
			end
			@domain.def_week = week
			@domain.save!
		else
			season = Array.new
			season << ""
			(1..12).each do |i|
				season << params[:domain]["def_season(#{i})"]
			end
			@domain.def_season = season
			@domain.save!
		end
		redirect_to :action => :index
	end

	def check_admin
    redirect_to root_path if current_user.is_admin != true
  end
end
