class Image < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  store_in_background :photo
end