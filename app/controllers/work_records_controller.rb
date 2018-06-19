class WorkRecordsController < ApplicationController
	def index
		@records = WorkRecord.all.order(id: :desc).paginate(:page => params[:page], per_page: 10)
	end

	def show
		@record_images = WorkRecordImage.where(:work_record_id => params[:id])
	end

	def outputs
		up = UserProfile.find_by_name(params[:name])
		beginning = "#{params[:s_month]}".to_i
		@work_projects = "" 
		WorkProject.all.each do |wp|
      @work_projects << wp.name
      @work_projects << "<br >"
    end
		@records = WorkRecord.where(:owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now)
		@before_records = WorkRecord.where(:record_type => 1, :owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now)
		@after_records = WorkRecord.where(:record_type => 2, :owner_id => up.user_id, :created_at => beginning.month.ago .. Time.now)
		respond_to do |format|
    	format.html
	    format.pdf do
	    	pdf = RecordPdf.new(@before_records, @after_records)
	    	send_data pdf.render, type: "application/pdf",
	    												disposition: "inline",
	    												filename: "Record_#{params[:name]}_#{params[:s_month]}"
	    end
	  end
	end
end
