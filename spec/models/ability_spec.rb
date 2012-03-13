require "spec_helper"
require "cancan/matchers"

describe Ability do
  
  describe "guest" do
    
    it "should be able to create a new user" do
      @guest = nil
      @guest_ability = Ability.new(@guest)
      @guest_ability.should be_able_to(:create, User)
    end
  end
  
  # before(:each) do
  #   @admin = Factory(:admin)
  #   @user_client = Factory(:client)
  #   @exercise = Factory(:exercise, user: @admin)
  #   @workout = Factory(:workout, user: @admin)
  # end
  
  describe "admin" do
    
    before(:each) do
      # @admin = Factory(:admin)
      # @admin_ability = Ability.new(@admin)
      # @exercise = Factory(:exercise, user_id: @admin.id)
      # @workout = Factory(:workout, user_id: @admin.id)
    end
    
    it "should be able to manage every-mutha-fuckin-thing" do
      @admin = Factory(:user, username: "admin1", email: "admin1@email.com", admin: true)
      @admin_ability = Ability.new(@admin)
      @admin_ability.should be_able_to(:manage, :all)
    end
  end
  
  describe "trainer_role" do
    
    before(:each) do
      @trainer = Factory(:user)
      @trainer_ability = Ability.new(@trainer)
    end
    
    describe "users" do
      
      it "should be able to view users" do
        @trainer_ability.should be_able_to(:read, User)
      end
      
      it "should be able to manage it's own account" do
        @trainer_ability.should be_able_to(:manage, @trainer)
      end
    end
    
    describe "exercises" do

      it "should be able to manage exercises for themselves" do
        @trainer_ability.should be_able_to(:manage, Factory(:exercise, user: @trainer))
      end

      it "shouldn't be able to manage another trainer's exercise" do
        @trainer_ability.should_not be_able_to(:manage, @exercise)
      end
      
      it "shouldn't be able to read another trainer's exercise" do
        @diff_trainer_exercise = Factory(:exercise)
        @trainer_ability.should_not be_able_to(:read, @diff_trainer_exercise)
      end
    end
    
    describe "workouts" do
      
      it "should be able to manage workouts for themselves" do
        @trainer_ability.should be_able_to(:manage, Factory(:workout, user: @trainer))
      end

      it "shouldn't be able to manage another trainer's exercise" do
        @trainer_ability.should_not be_able_to(:manage, @workout)
      end
    end
    
    describe "bookings" do
      
    end
  end
  
  describe "client_role" do
    
    before(:each) do
      @client = Factory(:client)
      @client_ability = Ability.new(@client)
    end
    
    describe "exercises" do
      
      it "should be able to manage their own profile" do
        @client_ability.should be_able_to(:manage, @client)
      end
      
      it "should be able to see other user's profiles" do
        @client_ability.should be_able_to(:read, User)
      end
      
      it "shouldn't be able to manage other user's profiles" do
        @client_ability.should_not be_able_to(:manage, @trainer)
      end
      
      it "should be able to view exercises" do
        @client_ability.should be_able_to(:read, @exercise)
      end

      it "should not be able to create exercises" do
        @client_ability.should_not be_able_to(:create, Exercise)
      end

      it "should not be able to update exercises" do
        @client_ability.should_not be_able_to(:update, Exercise)
      end

      it "should not be able to destroy exercises" do
        @client_ability.should_not be_able_to(:destroy, Exercise)
      end
    end
    
    describe "workouts" do
      
      it "should be able to view workouts" do
        @client_ability.should be_able_to(:read, @workout)
      end

      it "should not be able to create exercises" do
        @client_ability.should_not be_able_to(:create, Workout)
      end

      it "should not be able to update workouts" do
        @client_ability.should_not be_able_to(:update, Workout)
      end

      it "should not be able to destroy workout" do
        @client_ability.should_not be_able_to(:destroy, Workout)
      end
    end
  end
end