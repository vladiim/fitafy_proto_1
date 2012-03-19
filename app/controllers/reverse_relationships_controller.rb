class ReverseRelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:relationship][:trainer_id])
    current_user.get_trained!(@user)
    flash[:success] = "Trainer invited!"
    redirect_to @user
  end
end