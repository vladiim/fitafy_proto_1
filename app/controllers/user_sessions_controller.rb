class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Welcome back!"
      flash[:notice] = "You have new invites from trainers who want you as a client" if current_user.has_trainer_invitations?
      flash[:notice] = "You have new invites from clients who want you to train them!" if current_user.has_client_invitations?
      # if current_user.has_trainer_and_client_invitations?
      #   puts "Welcome back! Double invites yo"

    else
      flash[:error] = "Wrong email/password combination"
    end
    redirect_to root_path
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:success] = "Signed out!"
    redirect_to root_path
  end
end