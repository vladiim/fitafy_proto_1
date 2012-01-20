class Ability
  
  include CanCan::Ability
  
  def initialize user, options = {}
    if user
       @user = user
       admin_rules if @user.admin?
       trainer_rules if @user.role == "trainer_role"
       client_rules if @user.role == "client_role"
    else
      @guest = User.new
      guest_rules
    end
  end
  
  def guest_rules
    can :create, User
  end
  
  def admin_rules
    can :manage, :all
  end
  
  def trainer_rules
    can :read, [Exercise, Workout]
    can :manage, Exercise, :user_id => @user.id
    can :manage, Workout, :user_id => @user.id
    can :manage, Booking, :user_id => @user.id
  end
  
  def client_rules
    can :read, :all
  end
end