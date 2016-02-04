class Admin::PostsController < Admin::BaseController
  layout :preview_layout?

  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @image = Image.new
  end

  def create
    @post = Post.new(post_params)
    @image = Image.new

    if params[:preview_button]
      preview_post
    else
      if (params[:save_and_publish_button])
        @post.published_at = DateTime.now
      end

      if (@post.save)
        if (params[:save_and_publish_button])
          flash[:success] = "Post successfully saved and published."

          redirect_to admin_posts_url
        else
          flash[:success] = "Post successfully saved."

          redirect_to edit_admin_post_url(@post)
        end
      else
        flash.now[:danger] = "There were some errors while saving."
        render 'new'
      end
    end
  end

  def edit
    @image = Image.new
  end

  def update
    if params[:unpublish_button]
      @post.update_attribute(:published_at, nil)

      flash[:success] = "Post unpublished."
      redirect_to admin_posts_url
    else
      @post.assign_attributes(post_params)

      if params[:preview_button]
        preview_post
      else
        if (params[:save_and_publish_button])
          @post.published_at = DateTime.now
        end

        if (@post.save)
          if (params[:save_and_publish_button])
            flash[:success] = "Post successfully saved and published."

            redirect_to admin_posts_url
          else
            flash[:success] = "Post successfully saved."

            redirect_to edit_admin_post_url(@post)
          end
        else
          flash.now[:danger] = "There were some errors while saving."
          render 'edit'
        end
      end
    end
  end

  def destroy
    @post.destroy

    flash[:success] = "Post successfully deleted."
    redirect_to admin_posts_url
  end

  def destroy_multiple
    Post.destroy_all({ id: params[:post_ids] })

    flash[:success] = "Selected posts successfully deleted."
    redirect_to admin_posts_url
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def preview_layout?
      "application" if params[:preview_button]
    end

    def post_params
      params.require(:post).permit(:title, :category_id, :content, :image_id)
    end

    def preview_post
      @skip_header = true
      flash.now[:info] = "This is a preview."
      render 'preview'
    end
end