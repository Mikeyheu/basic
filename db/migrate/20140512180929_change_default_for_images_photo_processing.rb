class ChangeDefaultForImagesPhotoProcessing < ActiveRecord::Migration
  def change
    change_column :images, :photo_processing, :boolean, default: false
  end
end
