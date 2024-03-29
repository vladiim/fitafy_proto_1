require "spec_helper"
require "cancan/matchers"

describe Ability do
  
  before(:each) do
    @admin = Factory(:admin)
    @user_client = Factory(:client)
    @exercise = Factory(:exercise, user: @admin)
    @workout = Factory(:workout, user: @admin)
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
        @trainer_ability.should_not be_able_to(:manage, Factory(:exercise))
      end

      it "shouldn't be able to manage an admin's exercise" do
        @trainer_ability.should_not be_able_to(:manage, @exercise)
      end

      it "shouldn't be able to read another trainer's exercise" do
        @trainer_ability.should_not be_able_to(:read, Factory(:exercise))
      end

      it "should be able to read an admin's exercise" do
        @trainer_ability.should be_able_to(:read, @exercise)
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

    describe "relationships" do

      it "should be able to manage relationships where the trainer is a trainer" do
        @trainer_ability.should be_able_to(:manage, Factory(:relationship, trainer_id: @trainer.id))
      end

      it "should be able to manage relationships where they are a client" do
        @trainer_ability.should be_able_to(:manage, Factory(:relationship, client_id: @trainer.id))
      end

      it "should no be able to manage relationships where they are neither client or trainer" do
        @trainer_ability.should_not be_able_to(:manage, Factory(:relationship))
      end
    end
  end

  describe "client_role" do
    
    before(:each) do
      @client = Factory(:client)
      @client_ability = Ability.new(@client)
    end
    
    describe "exercises" do
      
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

    describe "reverse relationships" do

      it "should be able to manage relationships where they are a client" do
        @client_ability.should be_able_to(:manage, Factory(:relationship, client_id: @client.id))
      end

      it "should no be able to manage relationships where they are neither client or trainer" do
        @client_ability.should_not be_able_to(:manage, Factory(:relationship))
      end
    end
  end
end