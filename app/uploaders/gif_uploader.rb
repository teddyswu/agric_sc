# -*- encoding : utf-8 -*-

class GifUploader < CarrierWave::Uploader::Base

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

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{WebConf.upload_dir}/gif"
  end

  def extension_white_list
    %w(jpg jpeg gif png swf js)
  end

end
