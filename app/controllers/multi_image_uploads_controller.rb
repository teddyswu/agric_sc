class MultiImageUploadsController < ApplicationController
	before_filter :init_option_params, only: [:create]

	def new

	end
	def create
		if @option["resource_type"].present?
			case @option["resource_type"].downcase
      when 'work_record'
      	image = FbToAw.new(@table_params.except!(:watermark))
        image.file = params[:file]
        image.save!
        image.update_urls_success?
        user = UserProfile.find_by_name(@option["name"])
        work_record = WorkRecord.where(:owner_id => user.user_id).order(:id).last
        work_record_image = WorkRecordImage.new
        work_record_image.work_record_id = work_record.id
        work_record_image.cover_url = image.cover_url
        work_record_image.origin_url = image.origin_url
        work_record_image.show_url = image.show_url
        work_record_image.enabled = true
        work_record_image.save!
        render json: {:thumb => image.file.show.url, :big => image.file.show.url, :original => image.file.show.url}
      end
		end
	end

	def init_option_params
    @option = params[:option].present? ? JSON.parse(params[:option].gsub("&quot;", '"')) : Hash.new

    @table_params = params[:table_params].present? ? JSON.parse(params[:table_params].gsub("&quot;", '"')) : Hash.new
    @table_params[:watermark] = params[:watermark] if params[:watermark].present?
  end
end
