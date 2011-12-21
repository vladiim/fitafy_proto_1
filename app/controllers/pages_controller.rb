class PagesController < ApplicationController
  before_filter :auth_url if Rails.env.production?
  
  def home
  end
  
  protected
  
    def auth_url
      authenticate_or_request_with_http_basic do |username, password|
        username == "Its me Mario" && password == "Its me Luigi"
      end
    end
end
