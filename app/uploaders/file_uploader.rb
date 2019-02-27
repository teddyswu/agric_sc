# -*- encoding : utf-8 -*-

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  #include CarrierWave::Compatibility::Paperclip


  #=======================================================================================
  # imagemagick 不能用 就安裝 sudo apt-get install graphicsmagick 再加下面這段, 就可以使用了
  MiniMagick.processor = :gm
  #=======================================================================================

  # Choose what kind of storage to use for this uploader:
  storage :fog
  @@filename ||= "#{Time.now.strftime("%Y%m%d%H%M%S")}"

  def filename
    second=Time.now.strftime("%S").to_f*0.1
    file_sec= second.round
    @@filename = "#{Time.now.strftime("%Y%m%d%H%M%S")}"
    super != nil ? "#{@@filename}.png" : super # 重新命名附檔名
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{WebConf.upload_dir}/filelist"
  end

  def extension_white_list
    %w(jpg jpeg gif png swf js mov mp4 avi)
  end

end
