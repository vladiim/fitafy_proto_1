class BookingsController < ApplicationController
  respond_to :html, :json

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
    @presenter = Bookings::MasterPresenter.new(current_user)
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
    @presenter = Bookings::MasterPresenter.new(current_user, params[:id])
    @title = @presenter.show_title
    respond_with @presenter.booking, @presenter.exercises
  end

  def edit
    @presenter = Bookings::MasterPresenter.new(current_user, params[:id])
    @title = @presenter.edit_title
    respond_with @presenter.booking, @presenter.exercises
  end

  def update
    @presenter = Bookings::MasterPresenter.new(current_user, params[:id])
    flash[:success] = "Booking updated" if @presenter.booking.update_attributes(params[:booking])
    respond_with @presenter.booking
  end

  def destroy
    @booking = current_user.bookings.find(params[:id])
    @booking.destroy
    flash[:success] = "Booking deleted"
    redirect_to bookings_path
  end
end
