class Bookings::RequestsController < ApplicationController
  
  def new
    @booking = Booking.new
    @title = "Request Booking"
  end
  
  def create
    @booking_request = Booking.new(params[:booking])
    if @booking_request.save
      flash[:success] = "Booking requested, your trainer will confirm the time"
      redirect_to user_reverse_bookings_path(current_user)
    else
      render template: "bookings/new"
      @title = "Request Booking"
      @booking = Booking.new
    end
  end
end