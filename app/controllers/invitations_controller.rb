class InvitationsController < ApplicationController
  
  def new
    @title = "Invite New Client"
    @invitation = current_user.invitations.new
  end
  
  def create
    @invitation = current_user.invitations.new(params[:invitation])
    if @invitation.save
      flash[:success] = "Client invited! When they accept you can create bookings for the."
      redirect_to root_url
    else
      render :new
    end
  end
end