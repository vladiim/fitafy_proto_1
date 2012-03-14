class Bookings::RequestsController < ApplicationController
  
  def index
    if current_user.booking_requests.empty?
      redirect_to new_booking_path
      flash[:error] = "You have no booking requests, why not send one?"
    else
      @booking_requests = current_user.booking_requests
      @title = "Booking Requests"
    end
  end

  def new
    @booking = Booking.new
    @title = "Request Booking"
    @request_url = booking_requests_path
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
  
  def edit
    @booking = find_booking_request_by_user
    @title = "Suggest New Time"
    @request_url = booking_request_path(@booking)
  end
  
  def update
    find_booking_request_by_user
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
  
  def destroy
    find_booking_request_by_user
    @booking_request.destroy
    redirect_to booking_requests_path
    flash[:success] = "Booking request has been declined"
  end
  
  private 
  
    def find_booking_request_by_user
      if current_user.role == "trainer_role"
        @booking_request = current_user.bookings.find(params[:id])
      else
        @booking_request = current_user.reverse_bookings.find(params[:id])
      end
    end
end