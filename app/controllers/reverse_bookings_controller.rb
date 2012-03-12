class ReverseBookingsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if @user.reverse_bookings.empty?
      redirect_to new_booking_path
      flash[:message] = "There were no bookings for that client, why not make some?"
    else
      @bookings = @user.reverse_bookings
      @title = "Bookings for #{@user.username.titleize}"
    end
  end
end
