class Admin::SessionsController < ApplicationController
  layout 'admin/layout'

  def new
    @skip_nav = true
  end

  def create
    @skip_nav = true
    secret_key = Rails.configuration.x.recaptcha["secret_key"]
    response = params["g-recaptcha-response"]
    remote_ip = request.remote_ip
    
    if verify_recaptcha(secret_key, response, remote_ip)
      if params[:password] == Rails.configuration.x.preferences["admin_password"]
        session[:admin] = true
        flash[:success] = "Log in successful"

        redirect_to admin_posts_url
      else
        flash.now[:danger] = "Invalid password"
        render 'new'
      end
    else
      flash.now[:danger] = "There was an error with the reCAPTCHA. Please try again."

      render :new
    end
  end

  def destroy
    session[:admin] = nil
    redirect_to root_url
  end
end