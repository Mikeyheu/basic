# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # include ::CarrierWave::Backgrounder::Delay
  include CarrierWaveDirect::Uploader

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env =="production"
    storage :fog
  else
    storage :file
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [160, 120]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
