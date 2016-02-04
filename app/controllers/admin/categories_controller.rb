class Admin::CategoriesController < Admin::BaseController
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
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      flash[:success] = "Category successfully updated."
      redirect_to admin_categories_url
    else
      flash.now[:danger] = "There were some errors while updating."
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
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

    def category_params
      params.require(:category).permit(:title)
    end
end