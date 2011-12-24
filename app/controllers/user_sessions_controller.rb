class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save 
      UserSession.create @user # reason https://github.com/binarylogic/authlogic/issues/262#issuecomment-1804988
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
