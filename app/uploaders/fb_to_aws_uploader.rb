# encoding: utf-8

class FbToAwsUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include CarrierWave::Video  # for your video processing
  include CarrierWave::Video::Thumbnailer
  MiniMagick.processor = :gm

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{WebConf.upload_dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  

  version :thumb do
    process :auto_orient, :if => :is_jpg_file?
    process thumbnail: [{format: 'png', quality: 10, size: 350}], :if => :is_mp4_file?
    def full_filename for_file
      png_name for_file, version_name #if is_mp4_file(file)?
    end
    process :resize_to_fill_modf => [630, 630]
    process :resize_to_fill => [350, 350]
    # process :resize_to_fill => [350, 350]
    process convert: 'png'
    process :set_content_type_png
  end

  # version :cover do
  #   process :resize_to_fill => [600, 600], :if => :is_jpg_file?
  # end

  version :show do
    process :auto_orient, :if => :is_jpg_file?
    process :resize_and_pad => [536, 600, "black"], :if => :is_jpg_file?
    process :strip, :if => :is_jpg_file?
  end

  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
  end


  def is_mp4_file?(file)
    file.extension.downcase ==  'mp4'
  end

  def is_jpg_file?(file)
    file.extension.downcase ==  'jpg' or file.extension.downcase ==  'jpeg'
  end

  def set_content_type_png(*args)
    self.file.instance_variable_set(:@content_type, "image/png")
  end

  # def get_h_w
  #   manipulate! do |img|
  #     @width = img[:width]
  #     @height = img[:height]
  #     img = yield(img) if block_given?
  #     img
  #   end
  #   if @height.to_i > @width.to_i
  #     w = @height + 1
  #     resize_to_fill(350, 350)
  #   end
  # end

  def resize_to_fill_modf(width, height, gravity = 'Center', combine_options: {})
    manipulate! do |img|
      cols, rows = img[:dimensions]
      img.combine_options do |cmd|
        if width != cols || height != rows
          scale_x = width/cols.to_f
          scale_y = height/rows.to_f
          if scale_x >= scale_y
            cols = (scale_x * (cols + 0.5)).round
            rows = (scale_x * (rows + 0.5)).round
            cmd.resize "#{cols}"
          else
            cols = (scale_y * (cols + 0.5)).round
            rows = (scale_y * (rows + 0.5)).round
            cmd.resize "x#{rows}"
          end
        end
        cmd.gravity gravity
        cmd.background "rgba(255,255,255,0.0)"
        cmd.extent scale_x >= scale_y ? "#{350}x#{350}" : "#{width}x#{height}"
        append_combine_options cmd, combine_options
      end
      img = yield(img) if block_given?
      img
    end
  end

  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  def append_combine_options(cmd, combine_options)
    combine_options.each do |method, options|
      if options.nil?
        cmd.send(method)
      else
        cmd.send(method, options)
      end
    end
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
  def extension_white_list
    %w(jpg jpeg gif png mp4)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
