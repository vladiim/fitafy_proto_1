class Bookings::ExercisesController < ApplicationController
  
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
    @exercise = @booking.exercises.find(params[:id])
    if @exercise.update_attributes(params[:exercise])
      flash[:success] = "Exercise updated!"
      redirect_to booking_path(@booking)
    else
      @presenter = Bookings::ShowPresenter.new(current_user, params[:booking_id])
      render 'bookings/show'
    end
  end
  
  def destroy
    @booking = Booking.find(params[:booking_id])
    @exercise = @booking.exercises.find(params[:id])
    if @exercise.destroy
      flash[:success] = "Exercise removed!"
      redirect_to @booking
    end
  end
end