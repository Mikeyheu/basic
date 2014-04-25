class AddPhotoTmpToImages < ActiveRecord::Migration
  def change
    add_column :images, :photo_tmp, :string
  end
end
