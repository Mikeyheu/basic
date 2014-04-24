class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to images_path
    else
      render :index
    end
  end

  private

  def image_params
    params.require(:image).permit(:photo)
  end

end