class Bookings::ExercisesController < ApplicationController
  load_and_authorize_resource 
  
  def index
    
    @presenter = Exercises::ChildPresenter.new("Update Booking", "booking", (params[:booking_id]), current_user)
    
    # @title = "Update Booking"
    # @body_parts = Exercise::BODY_PARTS.sort
    # @model = "booking"
    # @parent = current_user.bookings.find(params[:booking_id])
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