class UsersController < ApplicationController   
  load_and_authorize_resource 
  
  def new
    @user = User.new
    @user.email = @user.invitation.recipient_email if @user.invitation_id
    @user_session = UserSession.new
    @title = "Sign Up"
  end
  
  def show
    @presenter = Users::ShowPresenter.new(current_user, params[:id])
    @title = @presenter.title
  end
    
  def create
    @user = User.new(params[:user])
    @user_session = UserSession.new
    if @user.save
      flash[:success] = "Welcome to fitafy!"
      redirect_to root_path
    else
      @title = "Sign Up"
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
      render :edit
      @title = "Update Profile"
    end
  end

  def destroy
  end
  
  def training
    @title = "Clients"
    if current_user.training.count == 1
      redirect_to new_client_path 
      flash[:message] = "Your only client is you! Why not invite some clients you can make money from?"
    else
      @user = User.find(params[:id])
      @clients = @user.training.order("username").paginate(:page => params[:page], :per_page => 10)
    end
  end
  
  def trained_by
    @title = "Trainers"
    @user = User.find(params[:id])
    @trainers = @user.trained_by.paginate(:page => params[:page], :per_page => 10)
  end
end
