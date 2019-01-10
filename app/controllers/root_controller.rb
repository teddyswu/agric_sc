class RootController < ApplicationController

	def index
		@project_domain = YAML.load_file("config/customization.yml")[:campaign_domain]
		headline_stories = Headline.where(:resource_type => "Story").order("RAND()").limit(1).map { |story| story.resource_id }
		@story = Story.where(:id => headline_stories)
		headline_projects = Headline.where(:resource_type => "Campaign").order("RAND()").limit(1).map { |project| project.resource_id }
		@project = Campaign.where(:id => headline_projects)
		att_campaign = Order.joins(:goody).select("goodies.campaign_id, count(goodies.campaign_id) as campaign_count").group("goodies.campaign_id").order("campaign_count DESC").limit(4).map { |campaign| campaign.campaign_id }
		att = att_campaign.unshift("id").to_s.gsub("\"","").gsub("[","").gsub("]","")
		att_campaign.delete("id")
		@att_projects = Campaign.where(:id => att_campaign).order("FIELD (#{att})")
		@new_projects = Campaign.where("status = 3 and start_date < ? ", Date.today + 7.days).limit(4)
		@story_cat_one = StoryCat.find_by_name("有機懶人包").stories.order("id DESC").limit(3)
		@story_cat_two = StoryCat.find_by_name("農村故事").stories.order("id DESC").limit(4)
		@work_walls = WorkDiaryImage.where.not(:position => nil, :enabled => false).order("updated_at DESC").limit(12)
		render layout: "story"
	end

end
