class Image < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  # process_in_background :photo
end