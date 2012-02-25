class Bookings::ExercisesController < ApplicationController
  load_and_authorize_resource 
  
  def edit
    
  end
  
  def update
    @booking = Booking.find(params[:booking_id])
    @exercise = @booking.exercises.find(params[:id])
    if @exercise.update_attributes(params[:exercise])
      flash[:success] = "Exercise updated!"
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end
end