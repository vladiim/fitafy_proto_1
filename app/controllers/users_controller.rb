class UsersController < ApplicationController   
  
  def new
    @user = User.new
    @user_session = UserSession.new
  end
  
  def create
    @user = User.new(params[:user])
    @user_session = UserSession.new
    if @user.save      
      flash[:success] = "Welcome to fitafy!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Your details have been updated"
      redirect_to edit_user_path(current_user)
    else
      render :new
    end
  end

  def destroy
  end

end
