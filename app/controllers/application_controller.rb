class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def verify_recaptcha(secret_key, response, remote_ip)
      uri = URI.parse('https://www.google.com/recaptcha/api/siteverify')

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({secret: secret_key,
                             response: response,
                             remoteip: remote_ip})

      response = http.request(request)

      JSON.parse(response.body)["success"]
    end
end