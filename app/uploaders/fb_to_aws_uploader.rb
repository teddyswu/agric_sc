# encoding: utf-8

class FbToAwsUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include CarrierWave::Video  # for your video processing
  include CarrierWave::Video::Thumbnailer

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{WebConf.upload_dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process thumbnail: [{format: 'png', quality: 10, size: 350}], :if => :is_mp4_file?
    def full_filename for_file
      png_name for_file, version_name #if is_mp4_file(file)?
    end
    process :resize_to_fill => [350, 350]
    process convert: 'png'
    process :set_content_type_png
  end

  # version :cover do
  #   process :resize_to_fill => [600, 600], :if => :is_jpg_file?
  # end

  version :show do
    process :resize_and_pad => [536, 600, "black"], :if => :is_jpg_file?
  end

  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
  end


  def is_mp4_file?(file)
    file.extension.downcase ==  'mp4'
  end

  def is_jpg_file?(file)
    file.extension.downcase ==  'jpg'
  end

  def set_content_type_png(*args)
    p self.file.content_type
    self.file.instance_variable_set(:@content_type, "image/png")
    p self.file.content_type
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

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
