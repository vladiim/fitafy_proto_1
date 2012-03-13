class Bookings::RequestsController < ApplicationController
  
  def create
    @booking_request = Booking.new(params[:booking])
    if @booking_request.save
      flash[:success] = "Booking requested, your trainer will confirm the time"
      redirect_to reverse_bookings_path
    else
      render template: "bookings/new"
      @title = "Request Booking"
      @booking = Booking.new
    end
  end
end