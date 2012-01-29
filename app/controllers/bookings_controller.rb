class BookingsController < ApplicationController
  
  def index
    @title = "Bookings"
    @bookings = current_user.bookings.paginate(:page => params[:page], :per_page => 10) 
  end
  
  def new
    @title = "Create Booking"
    @booking = current_user.bookings.new
    @workout = Workout.find(params[:workout]) if params[:workout]
    @workouts = current_user.workouts.collect { |w| [w.title, w.id] }
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
    @user = current_user
    @booking = @user.bookings.find(params[:id]) 
    @workout = @booking.workout
    @exercises = @workout.exercises
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
