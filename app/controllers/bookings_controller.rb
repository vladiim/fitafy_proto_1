class BookingsController < ApplicationController
  
  def index
    @title = "Bookings"    
    if current_user.bookings.empty?
      redirect_to new_booking_path
      flash[:message] = "You have no bookings, why not make some?"
    else
      @bookings = current_user.bookings.paginate(:page => params[:page], :per_page => 10)
    end
  end
  
  def new
    flash.keep
    @title = "Create Booking"
    @booking = current_user.bookings.new
    @workout = Workout.find(params[:workout]) if params[:workout]
    @client = Client.new
  end

  def create 
    @booking = current_user.bookings.new(params[:booking])
    if @booking.save 
      flash[:success] = "Booking created!"
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show
    @presenter = Bookings::ShowPresenter.new(current_user, params[:id])
    @title = @presenter.title
  end

  def edit
    @title = "Edit Booking"
    @user = current_user
    @booking = @user.bookings.find(params[:id])
    @client = Client.new
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
