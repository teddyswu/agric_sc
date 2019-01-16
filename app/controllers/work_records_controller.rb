class WorkRecordsController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :join_projects]
  before_action :is_admin, only: [:index]

	def index
		@records = WorkRecord.all.order(work_time: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def show
		@record_images = WorkRecordImage.where(:work_record_id => params[:id])
	end

	def mood
    record_mood = WorkDiaryMood.find_or_create_by(work_diary_id: params[:work_diary_id], user_id: params[:user_id]) 
    record_mood.save!
    
    record = WorkDiary.find(params[:work_diary_id])
    case record_mood.mood.to_i
    when 0
    	case params[:mood].to_i
    	when 1
    		record.smile = record.smile.to_i + 1
    	when 2
    		record.general = record.general.to_i + 1
    	when 3
    		record.dislike = record.dislike.to_i + 1
    	end
    when 1
    	record.smile = record.smile.to_i - 1
    	case params[:mood].to_i
    	when 2
    		record.general = record.general.to_i + 1
    	when 3
    		record.dislike = record.dislike.to_i + 1
    	end
    when 2
    	record.general = record.general.to_i - 1
    	case params[:mood].to_i
    	when 1
    		record.smile = record.smile.to_i + 1 
  		when 3
  			record.dislike = record.dislike.to_i + 1
  		end
    when 3
    	record.dislike = record.dislike.to_i - 1
    	case params[:mood].to_i
    	when 1 
    		record.smile = record.smile.to_i + 1 
    	when 2
    		record.general = record.general.to_i + 1
    	end
    end
    record.save!
    			

    mood = (record_mood.mood.to_i == params[:mood].to_i ? 0 : params[:mood])
    record_mood.update_column(:mood, mood)
	end

  def rate
    @campaign = Campaign.find(params[:id])
    render layout: 'story'
  end

  def record_img
    img = WorkRecordImage.find(params[:id])
    img.enabled = (img.enabled == true ? false :true)
    img.save!

    redirect_to work_records_path  
  end

  def join_projects
    @project_domain = YAML.load_file("config/customization.yml")[:campaign_domain]
    @groups = current_user.campaign_groups
    render layout: 'story'
  end

	def outputs
		up = current_user.present? ? FarmerProfile.find_by_user_id(current_user.id) : FarmerProfile.find_by_name(params[:name])
		@work_projects = "" 
    WorkProject.all.each do |wp|
      @work_projects << wp.name
      @work_projects << "<br >"
    end
    if params[:s_month].present?
      beginning = "#{params[:s_month]}".to_i
  		@records = WorkRecord.where(:owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now)
  		@before_records = WorkRecord.where(:record_type => 1, :owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now).order(work_time: :asc)
  		@after_records = WorkRecord.where(:record_type => 2, :owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now).order(work_time: :asc)
		else
      beginning = "#{params[:d_start]}".to_s
      finish = "#{params[:d_end]}".to_s
      @records = WorkRecord.where(:owner_id => up.user_id, :created_at => beginning .. finish)
      @before_records = WorkRecord.where(:record_type => 1, :owner_id => up.user_id, :created_at => beginning .. finish).order(work_time: :asc)
      @after_records = WorkRecord.where(:record_type => 2, :owner_id => up.user_id, :created_at => beginning .. finish).order(work_time: :asc)
    end

    respond_to do |format|
    	format.html{ render layout: 'story' }
	    format.pdf do
	    	pdf = RecordPdf.new(@before_records, @after_records)
	    	send_data pdf.render, type: "application/pdf",
	    												disposition: "inline",
	    												filename: "Record_#{params[:name]}_#{beginning}"
	    end
	  end
	end

  def new

  end

  def create
    aa = FbToAw.new(fb_params)
    aa.save!
    aa.update_urls_success?
    redirect_to :action => :new
  end

  def fb_params
    params.require(:fb_to_aw).permit(:remote_file_url)
  end

end
