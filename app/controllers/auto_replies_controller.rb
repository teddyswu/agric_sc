class AutoRepliesController < ApplicationController

	def index
		@auto_replies = AutoReply.all.order(id: :DESC).paginate(:page => params[:page], per_page: 10)
	end

	def new
		@auto_reply = AutoReply.new()
	end

	def edit
		@auto_reply = AutoReply.find(params[:id])
		@def_reply = AutoReplyReply.where(:auto_reply_id => params[:id], :is_default => true)
		# @replies = AutoReplyReply.where(:auto_reply_id => params[:id]).where.not(:is_default => true)
		@def_message = AutoReplyMessage.where(:auto_reply_id => params[:id], :is_default => true)
		# @messages = AutoReplyMessage.where(:auto_reply_id => params[:id]).where.not(:is_default => true)
		@rule_btn = AutoReplyRule.where(:auto_reply_id => params[:id], :parent_id => 0)
		@rule = AutoReplyRule.where(:auto_reply_id => params[:id])
	end

	def create
		@auto_reply = AutoReply.new()
		@auto_reply.url = params[:auto_reply][:url]
		@auto_reply.name = params[:auto_reply][:name]
		@auto_reply.default_pair = params[:auto_reply][:default_pair]
		@auto_reply.triggering_pair = params[:auto_reply][:triggering_pair]
		@auto_reply.enabled = true
		@auto_reply.save!

		@default_params = params[:auto_reply][:default]
		@default_params.each do |k, v|
			case k
			when /reply_reply/
				reply = AutoReplyReply.new()
				reply.auto_reply_id = @auto_reply.id
				reply.cat = v[:cat]
				reply.content = v[:content]
				reply.is_default = true
				reply.save!
			when /reply_message/
				message = AutoReplyMessage.new()
				message.auto_reply_id = @auto_reply.id
				message.cat = v[:cat]
				message.content = v[:content]
				message.is_default = true
				message.save!
			end
		end
		@params = params[:auto_reply]
		@params.each do |k, v|
			case k
			when /reply_reply/
				v.each do |a, b|
					reply = AutoReplyReply.new()
					reply.auto_reply_id = @auto_reply.id
					reply.cat = b[:cat]
					reply.content = b[:content]
					reply.is_default = false
					reply.group_id = b[:group_id]
					reply.save!
				end
			when /reply_message/
				v.each do |a, b|
					message = AutoReplyMessage.new()
					message.auto_reply_id = @auto_reply.id
					message.cat = b[:cat]
					message.content = b[:content]
					message.is_default = false
					message.group_id = b[:group_id]
					message.save!
				end
			when /reply_rule/
				parent_id = 0
				v.each do |a, b|
					rule = AutoReplyRule.new
					rule.auto_reply_id = @auto_reply.id
					rule.rule_cat = b[:rule_cat]
					rule.rule = b[:rule]
					rule.parent_id = parent_id
					rule.save!
					parent_id = rule.id if parent_id == 0
				end
			end
		end
		redirect_to :action => :index
	end

	def update
		@auto_reply = AutoReply.find(params[:id])
		b = AutoReplyRule.where(:auto_reply_id => params[:id])
		b.destroy_all
		c = AutoReplyReply.where(:auto_reply_id => params[:id])
		c.destroy_all
		d = AutoReplyMessage.where(:auto_reply_id => params[:id])
		d.destroy_all
		@auto_reply.url = params[:auto_reply][:url]
		@auto_reply.name = params[:auto_reply][:name]
		@auto_reply.default_pair = params[:auto_reply][:default_pair]
		@auto_reply.triggering_pair = params[:auto_reply][:triggering_pair]
		@auto_reply.enabled = true
		@auto_reply.save!

		@default_params = params[:auto_reply][:default]
		@default_params.each do |k, v|
			case k
			when /reply_reply/
				reply = AutoReplyReply.new()
				reply.auto_reply_id = @auto_reply.id
				reply.cat = v[:cat]
				reply.content = v[:content]
				reply.is_default = true
				reply.save!
			when /reply_message/
				message = AutoReplyMessage.new()
				message.auto_reply_id = @auto_reply.id
				message.cat = v[:cat]
				message.content = v[:content]
				message.is_default = true
				message.save!
			end
		end
		@params = params[:auto_reply]
		@params.each do |k, v|
			case k
			when /reply_reply/
				v.each do |a, b|
					reply = AutoReplyReply.new()
					reply.auto_reply_id = @auto_reply.id
					reply.cat = b[:cat]
					reply.content = b[:content]
					reply.is_default = false
					reply.group_id = b[:group_id]
					reply.save!
				end
			when /reply_message/
				v.each do |a, b|
					message = AutoReplyMessage.new()
					message.auto_reply_id = @auto_reply.id
					message.cat = b[:cat]
					message.content = b[:content]
					message.is_default = false
					message.group_id = b[:group_id]
					message.save!
				end
			when /reply_rule/
				parent_id = 0
				v.each do |a, b|
					rule = AutoReplyRule.new
					rule.auto_reply_id = @auto_reply.id
					rule.rule_cat = b[:rule_cat]
					rule.rule = b[:rule]
					rule.parent_id = parent_id
					rule.save!
					parent_id = rule.id if parent_id == 0
				end
			end
		end
		redirect_to :action => :index
	end

	def destroy
  	mp = AutoReply.find(params[:id])
  	mp.enabled = (mp.enabled == true ? false : true)
    mp.save!
  	redirect_to :action => :index
  end

	def temp_select
		render layout: false
	end
end
