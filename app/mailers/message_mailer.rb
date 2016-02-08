class MessageMailer < ActionMailer::Base
  default from: "Evrim Feyyaz Persembe <evrimfeyyaz@gmail.com>"
  default to: "Evrim Feyyaz Persembe <evrimfeyyaz@gmail.com>"

  def new_message(message)
    @message = message
    
    mail subject: "AppDevChallenge - Message from #{message.name}"
  end
end