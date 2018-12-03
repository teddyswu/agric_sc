class UserGroupsController < ApplicationController
	def index
		@groups = Group.all
	end
	def new
		@group = Group.new
		@auths = Authorization.all
	end
	def create
		@group = Group.new
		@group.name = params[:group][:name]
		@group.save!
		params[:user_ids].each do |ui|
			group_user_ship = GroupUserShip.create(:group_id => @group.id, :uid =>ui)
		end
		redirect_to user_groups_path
	end
	def destroy
		@group = Group.find(params[:id])
		@group_user_ship = GroupUserShip.where(:group_id => params[:id])
		@group.destroy
		@group_user_ship.destroy_all
		redirect_to user_groups_path
	end
	def edit
		@group = Group.find(params[:id])
		@auths = Authorization.all
		@group_user_ship = GroupUserShip.where(:group_id => params[:id]).map {|gu| gu.uid }
	end

	def update
		@group = Group.find(params[:id])
		@group.update(:name => params[:group][:name])
		@group.save!
		@group_user_ship = GroupUserShip.where(:group_id => params[:id])
		@group_user_ship.destroy_all
		params[:user_ids].each do |ui|
			group_user_ship = GroupUserShip.create(:group_id => @group.id, :uid =>ui)
		end
		redirect_to user_groups_path
	end

end
