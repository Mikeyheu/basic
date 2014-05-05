class AddPhotoProcessingToImages < ActiveRecord::Migration
  def change
    add_column :images, :photo_processing, :boolean
  end
end
