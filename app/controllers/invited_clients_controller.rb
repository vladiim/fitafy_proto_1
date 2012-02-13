class InvitedClientsController < ApplicationController
  before_filter :load_user_using_perishable_token
  
  def edit
    @title = "Create Account"
    @user_session = UserSession.new
    render "invited_clients/new"
  end

  def update
    @user_session = UserSession.new
    @user.username =              params[:user][:username]
    @user.password =              params[:user][:password]
    @user.password =              params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:success] = "Welcome to fitafy!"
      redirect_to root_path
    else
      render :edit
    end
  end
  
  private
  
    def load_user_using_perishable_token
      @user = User.find_by_perishable_token(params[:id]) || User.find_by_perishable_token(params[:user][:id])
      unless @user
        flash[:notice] = "The url you entered isn't valid, try copy and pasting in out of your email again"
        redirect_to root_url
      end
    end
end
