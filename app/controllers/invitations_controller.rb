class InvitationsController < ApplicationController

  def index
    flash.keep
    if current_user.has_trainer_and_client_invitations?
      @invitations = current_user.find_trainer_and_client_invitations

    elsif current_user.has_trainer_invitations?
      @invitations = current_user.find_trainer_invitations

    elsif current_user.has_client_invitations?
      @invitations = current_user.find_client_invitations

    else
      redirect_to root_path
      flash[:notify] = "You haven't got any invites"
    end
  end

  def new
    @title = "Invite New Client"
    @invitation = current_user.invitations.new
  end

  def create
    @invitation = current_user.invitations.new(params[:invitation])
    if @invitation.save
      flash[:success] = "Client invited!"
      redirect_to root_url
    else
      render :new
    end
  end
end