class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def new
    @title = "Reset Password"
    @user_session = UserSession.new    
    render :new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_password_reset_instructions! if @user
    flash[:success] = "Instructions to reset your password have been sent"
    redirect_to root_path
  end
  
  def edit
    @user_session = UserSession.new
    render
  end
  
  def update
    @user_session = UserSession.new
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:success] = "Your password has been updated!"
      redirect_to root_path
    else
      render :edit
    end
  end
end
