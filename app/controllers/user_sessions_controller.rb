class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save 
      flash[:notice] = "Welcome back!"
      redirect_to root_path
    elsif @user_session.nil?
      logger.debug "user_sessions is:" + @user_sessions.inspect
    else
      render :new
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to root_path
  end
  
end
