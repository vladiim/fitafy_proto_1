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
  
  def make_themself_a_client
    trainer_already_trains_themself = Relationship.where("trainer_id = ? AND client_id = ?", @user.id, @user.id)
    unless trainer_already_trains_themself
      @user.train!(@user) if @user.role == "trainer_role"
    end
  end
end