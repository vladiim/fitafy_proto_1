class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save  
      flash[:notice] = "Welcome back!"
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
