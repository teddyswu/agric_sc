class WorkRecordsController < ApplicationController
	def index
		@records = WorkRecord.all.paginate(:page => params[:page], per_page: 10)
	end

	def outputs
		up = UserProfile.find_by_fb_uid(params[:uid])
		beginning = "#{params[:s_month]}".to_i
		@work_projects = "" 
		WorkProject.where(:record_type =>params[:record_type]).each do |wp|
      @work_projects << wp.name
      @work_projects << "<br >"
    end
		@records = WorkRecord.where(:record_type => params[:record_type], :owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now).paginate(:page => params[:page], per_page: 10)
		respond_to do |format|
    	format.html
	    format.pdf do
	    	pdf = RecordPdf.new(@records, @work_projects, params[:record_type])
	    	send_data pdf.render, type: "application/pdf",
	    												disposition: "inline"
	    end
	  end
	end
end
