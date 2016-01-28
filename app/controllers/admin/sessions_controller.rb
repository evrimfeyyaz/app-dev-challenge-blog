class Admin::SessionsController < ApplicationController
  layout 'admin/layout'

  def new
    @skip_nav = true
  end

  def create
    @skip_nav = true

    if params[:password] == Rails.configuration.x.preferences["admin_password"]
      session[:admin] = true
      flash[:success] = "Log in successful"

      redirect_to admin_posts_url
    else
      flash.now[:danger] = "Invalid password"
      render 'new'
    end
  end

  def destroy
    session[:admin] = nil
    redirect_to root_url
  end
end