class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    @user = user
    make_themself_a_client
  end
  
  def after_update(user)
    @user = user
    make_themself_a_client
  end
  
  private
  
  def trainer_already_trains_themself
    trainer_already_trains_themself = Relationship.where(trainer_id: @user.id, client_id: @user.id)
    !trainer_already_trains_themself.empty?
  end
  
  def make_themself_a_client
    if @user.role == "trainer_role"
      @user.train!(@user) unless trainer_already_trains_themself
    end
  end
end