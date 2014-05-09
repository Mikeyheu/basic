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
    file_ids = params[:file_ids]

    # unprocessed = Image.where(id:file_ids, photo_processing:nil).pluck(:id)
    done_processing = Image.where(id:file_ids, photo_processing:nil).pluck(:id)

    respond_to do |format|
      format.json { render json:  { done_processing: done_processing } }
    end
  end

  private

  def image_params
    params.require(:image).permit(:photo)
  end

end