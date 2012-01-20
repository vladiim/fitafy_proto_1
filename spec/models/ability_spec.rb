require "spec_helper"
require "cancan/matchers"

describe Ability do
  
  before(:each) do
    @admin = Factory(:user, :admin => true)
    @user_client = Factory(:user, :role => "client_role")
    @exercise = Factory(:exercise, :user => @admin)
    @workout = Factory(:workout, :user => @admin)
    @booking = Factory(:booking, :trainer => @admin)
  end
  
  describe "guest" do
    
    before(:each) do
      @guest = nil
      @guest_ability = Ability.new(@guest)      
    end
    
    it "should be able to create a new user" do
      @guest_ability.should be_able_to(:create, User)
    end
    
  end
  
  describe "admin" do
    
    before(:each) do
      @admin_ability = Ability.new(@admin)
    end
    
    it "should be able to manage every-mutha-fuckin-thing" do
      @admin_ability.should be_able_to(:manage, :all)
    end
  end
  
  describe "trainer_role" do
    
    before(:each) do
      @trainer = Factory(:user, :role => "trainer_role")
      @trainer_ability = Ability.new(@trainer)
    end
    
    describe "exercises" do
      
      it "should be able to read exercises" do
        @trainer_ability.should be_able_to(:read, @exercise)
      end

      it "should be able to manage exercises for themselves" do
        @trainer_ability.should be_able_to(:manage, Factory(:exercise, :user => @trainer))
      end

      it "shouldn't be able to manage another trainer's exercise" do
        @trainer_ability.should_not be_able_to(:manage, @exercise)
      end
    end
    
    describe "workouts" do
      
      it "should be able to read workouts" do
        @trainer_ability.should be_able_to(:read, @workout)
      end

      it "should be able to manage workouts for themselves" do
        @trainer_ability.should be_able_to(:manage, Factory(:workout, :user => @trainer))
      end

      it "shouldn't be able to manage another trainer's exercise" do
        @trainer_ability.should_not be_able_to(:manage, @workout)
      end
    end
    
    describe "bookings" do
      
      # it "should not be able to read other people's bookings" do
      #   @trainer_ability.should_not be_able_to(:read, @booking)
      # end
      # 
      # it "should be able to manage bookings for themselves" do
      #   @trainer_ability.should be_able_to(:manage, Factory(:booking, :user => @trainer))
      # end
      # 
      # it "shouldn't be able to manage another trainer's booking" do
      #   @trainer_ability.should_not be_able_to(:manage, @booking)
      # end
    end
  end
  
  describe "client_role" do
    
    before(:each) do
      @client = Factory(:user, :role => "client_role")
      @client_ability = Ability.new(@client)
    end
    
    describe "exercises" do
      
      it "should be able to view exercises" do
        @client_ability.should be_able_to(:read, @exercise)
      end

      it "should only be able to view exercises belonging to them"

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

      it "should only be able to view workouts belonging to them"

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