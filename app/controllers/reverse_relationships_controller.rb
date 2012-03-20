class ReverseRelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:relationship][:trainer_id])
    current_user.get_trained!(@user)
    flash[:success] = "Trainer invited!"
    redirect_to @user
  end
  
  def destroy
    @user = User.find(params[:relationship][:trainer_id])
    @relationship = current_user.reverse_relationships.find_by_trainer_id(@user.id)
    @relationship.destroy
    redirect_to @user
    flash[:success] = "Trainer removed."
  end
end