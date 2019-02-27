# encoding: utf-8

class StoryUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  MiniMagick.processor = :gm

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog
  @@filename ||= "#{Time.now.strftime("%Y%m%d%H%M%S")}"

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def filename
    second=Time.now.strftime("%S").to_f*0.1
    file_sec= second.round
    @@filename = "#{Time.now.strftime("%Y%m%d%H%M%S")}"
    super != nil ? "#{@@filename}.png" : super # 重新命名附檔名
  end

  def store_dir
    "#{WebConf.upload_dir}/story/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end


  version :headline do
    process :resize_to_fill => [1110, 350]
  end

  version :cover do
    process :resize_and_pad => [350, 233]
  end
  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
