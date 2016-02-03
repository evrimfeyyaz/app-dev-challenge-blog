class PostsController < ApplicationController
  def index
    @posts = Post.published
  end

  def show
    @post = Post.find(params[:id])

    @skip_header = true
  end
end