class BookingsController < ApplicationController
  
  def index
    @title = "Bookings"
    @bookings = current_user.bookings.paginate(:page => params[:page], :per_page => 10) 
  end
  
  def new
    @title = "Create Booking"
    @user = current_user
    @booking = @user.bookings.new
  end

  def create 
    @user = current_user
    @booking = @user.bookings.new(params[:booking])
    if @booking.save
      flash[:success] = "Booking created!"
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show
    @user = current_user
    @booking = @user.bookings.find(params[:id]) 
    @client = User.find(@booking.client_id)
    @title = "Booking for: #{@client.username}"    
  end

  def edit
    @title = "Edit Booking"
    @user = current_user
    @booking = @user.bookings.find(params[:id])
  end

  def update
    @booking = current_user.bookings.find(params[:id])
    if @booking.update_attributes(params[:booking])
      flash[:success] = "Booking updated"
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

  def destroy
    @booking = current_user.bookings.find(params[:id])
    @booking.destroy
    flash[:success] = "Booking deleted"
    redirect_to bookings_path
  end

end
