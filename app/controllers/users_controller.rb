class UsersController < ApplicationController   
  load_and_authorize_resource 
  
  def new
    @user = User.new
    @user.email = @user.invitation.recipient_email if @user.invitation_id
    @user_session = UserSession.new
  end
  
  def show
    @user = User.find(params[:id])
    @relationship = current_user.relationships.find_by_client_id(@user.id)
    @title = @user.username.titleize
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
    @title = "Update Profile"      
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
  
  def training
    @title = "Clients"
    @user = User.find(params[:id])
    @clients = @user.training.paginate(:page => params[:page], :per_page => 10)
  end
  
  def trained_by
    @title = "Trainers"
    @user = User.find(params[:id])
    @trainers = @user.trained_by.paginate(:page => params[:page], :per_page => 10)
  end
end
