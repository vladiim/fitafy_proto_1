class InvitationsController < ApplicationController
  
  def new
    @title = "Invite New Client"
    @invitation = current_user.invitations.new
  end
  
  def create
    @invitation = current_user.invitations.new(params[:invitation])
    if @invitation.save
      flash[:success] = "Client invited! In the meantime feel free to create bookings for them."
      redirect_to root_url
    else
      render :new
    end
  end
end