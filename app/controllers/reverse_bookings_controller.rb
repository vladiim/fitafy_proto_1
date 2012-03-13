class ReverseBookingsController < ApplicationController
  def index
    flash.keep
    @user = User.find(params[:user_id])

    if @user.reverse_bookings.empty?
      redirect_to new_booking_path

        if current_user.role == "trainer_role"
          flash[:message] = "There were no bookings for that client, why not make some?"
        elsif
          flash[:message] = "You have no bookings, why not make some?"
        end

    else
      @bookings = @user.reverse_bookings
      @title = "Bookings for #{@user.username.titleize}"
    end
  end
end
