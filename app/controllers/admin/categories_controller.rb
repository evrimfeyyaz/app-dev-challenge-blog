class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category successfully created."
      redirect_to admin_categories_url
    else
      flash.now[:danger] = "There were some errors while saving."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category successfully updated."
      redirect_to admin_categories_url
    else
      flash.now[:danger] = "There were some errors while updating."
      render 'edit'
    end
  end

  def destroy
    @category.destroy

    flash[:success] = "Category successfully deleted."
    redirect_to admin_categories_url
  end

  def destroy_multiple
    Category.destroy_all({ id: params[:category_ids] })

    flash[:success] = "Selected categories successfully deleted."
    redirect_to admin_categories_url
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
end