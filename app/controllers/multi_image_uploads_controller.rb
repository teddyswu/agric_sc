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
        user = FarmerProfile.find_by_name(@option["name"])
        last_five_ids = WorkDiary.last(5).reverse.map {|work| work.id }
        wdc = WorkDiary.where(:id => last_five_ids, :comment => "multi_upload", :owner_id => user.user_id ).where("created_at > '#{Time.now - 9.hour}'").limit(1)
        if wdc.present?
          wdc[0].work_diary_images.create( :url => "", :cover_url => image.cover_url, :origin_url => image.origin_url, :show_url => image.show_url, :enabled => true )
        else
          wd = WorkDiary.new
          wd.owner_id = user.user_id
          wd.comment = "multi_upload"
          wd.diary_time = Time.now
          wd.save!
          wd.work_diary_images.create( :url => "", :cover_url => image.cover_url, :origin_url => image.origin_url, :show_url => image.show_url, :enabled => true )
        end
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
