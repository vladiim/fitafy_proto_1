class ReverseBookingsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @bookings = @user.reverse_bookings
    @title = "Bookings for #{@user.username}"
  end
end
