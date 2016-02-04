class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :require_admin_for_unpublished, except: [:index]

  def index
    @posts = Post.published
  end

  def show
    @skip_header = true
  end

  private

    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def require_admin_for_unpublished
      unless @post.published? || session[:admin]
        redirect_to root_url
      end
    end
end