class RelationshipsController < ApplicationController

  def index
    # flash.keep
    # @title = "Invites"
    # if current_user.role = "client_role"
    #    @relationships = Relationship.unaccepted.where(client_id: current_user.id)
    #   redirect_to root_path if @relationships.empty?
    # end
  end

  def create
    @user = User.find(params[:relationship][:client_id])
    current_user.train!(@user)
    flash[:success] = "Client invited, feel free to make bookings for them while they accept your invite"
    redirect_to @user
  end

  def update
    @relationship = Relationship.find(params[:id])
    if @relationship.update_attributes(params[:relationship])
      if @relationship.accepted
        flash[:success] = "Invite accepted!"
      else
        flash[:success] = "Invite declined."
      end
      redirect_to invitations_path
    else
      render :index
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).client
    current_user.untrain!(@user)
    flash[:success] = "Client removed."
    redirect_to @user
  end
end