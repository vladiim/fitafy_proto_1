require "spec_helper"
require "cancan/matchers"

# FOR WHATEVER REASON, FACTORY GIRL STARTED FAILING TO CREATE 
# UNIQUE USERNAMES & EMAILS FOR THIS SPEC HENCE THE LACK OF DRY
#TARTED AT COMMIT a401221d68a55fb8714ee1b7a0f52b506ff98f6f

describe Ability do
  
  describe "guest" do
    
    it "should be able to create a new user" do
      @guest = nil
      @guest_ability = Ability.new(@guest)
      @guest_ability.should be_able_to(:create, User)
    end
    
  end
  
  describe "admin" do
    
    it "should be able to manage every-mutha-fuckin-thing" do
      @admin = Factory(:admin, username: "unique1", email: "unique1@email.com")
      @admin_ability = Ability.new(@admin)
      @admin_ability.should be_able_to(:manage, :all)
    end
  end
  
  describe "trainer_role" do

    describe "users" do
      
      it "should be able to view users" do
        @trainer = Factory(:user, username: "unique2", email: "unique2@email.com")
        @trainer_ability = Ability.new(@trainer)
        @trainer_ability.should be_able_to(:read, User)
      end
      
      it "should be able to manage it's own account" do
        @trainer = Factory(:user, username: "unique3", email: "unique3@email.com")
        @trainer_ability = Ability.new(@trainer)
        @trainer_ability.should be_able_to(:manage, @trainer)
      end    
    end
    
    describe "exercises" do

      it "should be able to manage exercises for themselves" do
        @trainer = Factory(:trainer)
        @trainer_ability = Ability.new(@trainer)

        @trainer_ability.should be_able_to(:manage, Factory(:exercise, user: @trainer))
      end

      it "shouldn't be able to manage another trainer's exercise" do
        @trainer = Factory(:trainer)
        @trainer_ability = Ability.new(@trainer)
        @trainer2 = Factory(:trainer)
        @exercise = Factory(:exercise, user_id: @trainer2.id)

        @trainer_ability.should_not be_able_to(:manage, @exercise)
      end
      
      it "shouldn't be able to read another trainer's exercise" do
        @trainer = Factory(:trainer)
        @trainer_ability = Ability.new(@trainer)
        @trainer2 = Factory(:trainer)
        @exercise = Factory(:exercise, user_id: @trainer2.id)

        @trainer_ability.should_not be_able_to(:read, @exercise)
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