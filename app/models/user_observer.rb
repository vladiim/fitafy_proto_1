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
    @user.train!(@user) if @user.role == "trainer_role"
  end
end