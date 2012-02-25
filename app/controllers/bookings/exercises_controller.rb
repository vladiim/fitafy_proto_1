class Bookings::ExercisesController < ApplicationController
  load_and_authorize_resource 
  
  def index
    @presenter = Exercises::ChildPresenter.new("Add Exercises", "booking", (params[:booking_id]), current_user)
    @title = @presenter.title
  end
  
  def create
    @booking = Booking.find(params[:booking_id])
    if @booking.add_exercises(params[:booking][:exercise_ids])
      flash[:success] = "Booking updated!"
      redirect_to booking_path(@booking)
    else
      render :index
    end
  end
  
  def update
    @booking = Booking.find(params[:booking_id])
    if @booking.update_attributes(params[:exercise])
      flash[:success] = "Exercise updated!"
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end
end