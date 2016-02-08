require 'net/https'
require 'open-uri'

class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    secret_key = Rails.configuration.x.recaptcha["secret_key"]
    response = params["g-recaptcha-response"]
    remote_ip = request.remote_ip
    
    if verify_recaptcha(secret_key, response, remote_ip)
      if @message.valid?
        MessageMailer.new_message(@message).deliver_now

        flash[:success] = "Your messages has been sent." 
        redirect_to contact_path
      else
        flash.now[:danger] = "An error occurred while delivering this message."

        render :new
      end
    else
      flash.now[:danger] = "There was an error with the reCAPTCHA. Please try again."

      render :new
    end
  end

private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end
end