class ClientsController < ApplicationController
  before_filter :load_user_using_perishable_token, only: [:edit, :update]
  
  def new
    @title = "Invite New Client"
    @client = Client.new
  end
  
  def create
    @client = Client.new(params[:client])
    @trainer = current_user
    if @client.valid?
      @client.trainer_creates_client(@trainer)
      flash[:success] = "New client invited! You can create workouts & bookings for them once they confirm their account"
      redirect_to :root
    else
      render :new
    end
  end
  
  def edit
    @title = "Complete Your Profile"
    @user_session = UserSession.new
  end
end