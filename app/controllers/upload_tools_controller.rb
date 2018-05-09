# -*- encoding : utf-8 -*-
class UploadToolsController < ApplicationController

  # 多圖上傳參考下列網址
  # 分享
  # http://gloryspring.blog.51cto.com/5470544/1065808
  # Demo
  # https://code.google.com/p/swfupload/
  # before_filter :init_picture
  skip_before_action :verify_authenticity_token
  before_filter :init_option_params

  def create
    if @option["resource_type"].present?
    	case @option["resource_type"].downcase
      when 'typecomic'
        product = Product.find(@option["resource_id"].to_i)
        @table_params[:user_id] = current_user.id # ckeditor沒有user_id, 所以寫在這
        media = product.albums.new(@table_params)
        media.file = params[:file]
        media.save!
        media.update_urls_success?
        render json: {:small => media.file.small.url, :medium => media.file.medium.url, :big => media.file.big.url, :original => media.file.url}
      when 'typegif'
        gif = TypeGif.new(@table_params.except!(:watermark))
        gif.file =  params[:file]
        gif.url = "sss"
        gif.save!
        gif.url = gif.file.url
        gif.save!
        gif_ship = DigitalResourceShip.new
        gif_ship.resource_type = "TypeGif"
        gif_ship.resource_id = gif.id
        gif_ship.encryption = "ss"
        gif_ship.title = "gif"
        gif_ship.save!
        render json: {:thumb => gif.file.url, :big => gif.file.url, :original => gif.file.url}
      when 'gifedit'
        gif = DigitalResourceShip.find(@table_params["id"])
        gif.resource.file =  params[:file]
        gif.resource.save!
        gif.resource.url = gif.resource.file.url
        gif.resource.save!
        render json: {:thumb => gif.resource.file.url, :big => gif.resource.file.url, :original => gif.resource.file.url}
      when 'filelist'
        filelist = FileList.new(@table_params.except!(:watermark))
        filelist.file = params[:file]
        filelist.save!
        filelist.url = filelist.file.url
        filelist.save!
        render json: {:thumb => filelist.file.url, :big => filelist.file.url, :original => filelist.file.url}
      when 'article'
        filelist = FileList.new(@table_params.except!(:watermark))
        filelist.file = params[:file]
        filelist.save!
        filelist.url = filelist.file.url
        filelist.save!
        render json: {:thumb => filelist.file.url, :big => filelist.file.url, :original => filelist.file.url}
      end
    else
      media = current_user.upload_photos.new(@table_params)
      media.data = params[:file]
      media.save!
      render json: {:thumb => media.data.thumb.url, :big => media.data.big.url, :original => media.data.url}
    end
  rescue => e
    logger.error(e)
  end

  protected

  def init_option_params
    @option = params[:option].present? ? JSON.parse(params[:option].gsub("&quot;", '"')) : Hash.new

    @table_params = params[:table_params].present? ? JSON.parse(params[:table_params].gsub("&quot;", '"')) : Hash.new
    @table_params[:watermark] = params[:watermark] if params[:watermark].present?
  end
end
