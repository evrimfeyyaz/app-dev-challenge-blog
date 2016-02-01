class Admin::ImagesController < Admin::BaseController
  def index
    @images = Image.all
    @image = Image.new
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:success] = "Image successfully uploaded."
      redirect_to admin_images_url
    else
      flash[:danger] = "There were some errors during upload."
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    flash[:success] = "Image successfully deleted."
    redirect_to admin_images_url
  end

  private

    def image_params
      params.require(:image).permit(:data)
    end
end