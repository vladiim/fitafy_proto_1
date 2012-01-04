class PagesController < ApplicationController
  before_filter :auth_url if Rails.env.production?
  
  def home
    @user = User.new
    @user_session = UserSession.new
  end
  
  protected
  
    def auth_url
      authenticate_or_request_with_http_basic do |username, password|
        username == "Its me Mario" && password == "Its me Luigi"
      end
    end
end
