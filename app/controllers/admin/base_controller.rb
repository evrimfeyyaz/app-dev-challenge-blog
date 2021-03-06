class Admin::BaseController < ApplicationController
  layout 'admin/layout'

  before_action :require_admin

  private

    def require_admin
      unless session[:admin]
        redirect_to root_url
      end
    end
end