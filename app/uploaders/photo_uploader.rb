# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWaveDirect::Uploader
  include CarrierWave::MiniMagick

  if Rails.env =="production"
    storage :fog
  else
    storage :file
  end

  # version :thumb do
  #   process :resize_to_fill => [160, 120]
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
