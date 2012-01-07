class RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:relationship][:client_id])
    current_user.train!(@user)
    flash[:success] = "Client invited, feel free to make bookings for them while they accept your invite"
    redirect_to @user
  end
  
  def destroy
    @user = Relationship.find(params[:id]).client
    current_user.untrain!(@user)
    flash[:success] = "Client removed."
    redirect_to @user
  end
end