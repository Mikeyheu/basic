class ImagesController < ApplicationController
  def index
    @images = Image.all
    respond_to do |format|
      format.html { }
      format.json { render json: @images }
    end
  end

  def show
    @image = Image.find(params[:id])  
    data = { image_id: @image.id }
    respond_to do |format|
      format.html { render json: @image }
      format.json { render json: @image }
    end
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to images_path }
        format.json { 
          data = { image_id: @image.id }
          render json: data
        }
      else
        format.html { render :index }
        format.json { render json: @image.errors }
      end
    end
  end

  def check_processed
    images = Image.where(id:params[:file_ids], photo_processing:nil)
    puts "Images where photo_processing is nil:"
    puts images

    image_ids = []
    image_urls = []
    images.each_with_index do |image|
      image_ids << image.id
      image_urls << image.photo_url(:thumb)
    end

    respond_to do |format|
      format.json { render json: { image_ids: image_ids, image_urls: image_urls } }
    end
  end

  private

  def image_params
    params.require(:image).permit(:photo)
  end

end