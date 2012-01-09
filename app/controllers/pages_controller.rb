class PagesController < ApplicationController
  before_filter :auth_url if Rails.env.production?
  
  def home
    if current_user.nil?
      @user = User.new 
    else
      @title = "Create Booking"
      @user = current_user
      @booking = current_user.bookings.new
    end
    @user_session = UserSession.new
  end
  
  protected
  
    def auth_url
      authenticate_or_request_with_http_basic do |username, password|
        username == "Its me Mario" && password == "Its me Luigi"
      end
    end
end
