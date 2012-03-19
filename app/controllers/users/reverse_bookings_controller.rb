class Users::ReverseBookingsController < ApplicationController
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
  
  def create
    @user = User.find(params[:reverse_relationship][:trainer_id])
    current_user.get_trained!(@user)
    flash[:success] = "Trainer invited!"
    redirect_to @user
  end
end
