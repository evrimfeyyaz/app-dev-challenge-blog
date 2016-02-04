class Admin::ImagesController < Admin::BaseController
  before_action :set_image, only: [:show, :destroy]

  def index
    @images = Image.all
    @image = Image.new

    respond_to do |format|
      format.js { @mode = params[:mode] }
      format.html
    end
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      respond_to do |format|
        format.html {
          flash[:success] = "Image successfully uploaded."
          redirect_to admin_images_url
        }

        format.js {
          @mode = params[:choose_image_mode]
          @thumb_2x_url = @image.data.url(:thumb_2x)
          @original_url = @image.data.url
          @image_id = @image.id
        }
      end
      
    else
      flash.now[:danger] = "There were some errors during upload."
      render 'new'
    end
  end

  def show
  end

  def destroy
    @image.destroy

    flash[:success] = "Image successfully deleted."
    redirect_to admin_images_url
  end

  def destroy_multiple
    Image.destroy_all({ id: params[:image_ids] })

    flash[:success] = "Selected images successfully deleted."
    redirect_to admin_images_url
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:data)
    end
end