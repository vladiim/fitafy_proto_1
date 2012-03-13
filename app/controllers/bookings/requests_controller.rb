class Bookings::RequestsController < ApplicationController
  
  def index
    if current_user.booking_requests.empty?
      
      if current_user.role == "trainer_role"
        redirect_to new_booking_path
      else
      end
      flash[:error] = "You have no booking requests, why not send one?"
      
    else
      @booking_requests = current_user.booking_requests
      @title = "Booking Requests"
    end
  end
  
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
  
  def update
    @booking_request = current_user.booking_requests.find(param[:id])
    if @booking_request.update_attributes(params[:booking])
      redirect_to booking_requests_path
      if @booking_request.status == "confirmed"
        flash[:success] = "Booking has been confirmed!"
      else
        flash[:success] = "Booking has been declined"
      end
    else
      render :edit
    end
  end
end