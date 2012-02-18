class ClientsController < ApplicationController
  
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
    end
  end
end