class Users::CompletedReverseBookingsController < ApplicationController
  
  def index
    @title = "Completed Workouts"
    if current_user.completed_reverse_bookings.empty?
      redirect_to user_reverse_bookings_path(current_user)
      flash[:error] = "You'll see your workouts once you finish a booking"
    else
      @completed_bookings = current_user.completed_reverse_bookings
    end
  end
end