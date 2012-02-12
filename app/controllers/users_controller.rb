class UsersController < ApplicationController   
  load_and_authorize_resource except: :edit
  
  def new
    @user = User.new
    @user.email = @user.invitation.recipient_email if @user.invitation
    @user_session = UserSession.new
  end
  
  def show
    @user = User.find(params[:id])
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
    if (params[:invitation_token]).present?
      invitation = Invitation.find_by_token(params[:invitation_token])
      @user = User.find_by_invitation_id(invitation.id)
      
      @title = "Create Profile"
    else
      @user = current_user
      @title = "Update Profile"      
    end
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
