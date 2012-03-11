require 'spec_helper'

describe "Workouts" do
  
  before(:each) do
    @trainer = Factory(:user)
    integration_sign_in(@trainer)
    @exercise = Factory(:exercise, user_id: @trainer.id)
    @workout_title = "Da heaps Hardcore Workout"
    @workout_instructions = "Not for the feignt hearted"
  end
  
  it "creates a new workout" do
    visit root_path
    click_link("Workouts: ")
    current_path.should eq(new_workout_path)
    fill_in "workout_title", with: @workout_title
    fill_in "workout_instructions", with: @workout_instructions
    check("exercise_#{@exercise.id}")
    click_button("Create Workout")
    page.should have_content("New workout added!")
    page.should have_content("#{@workout_title}")
  end
  
  it "tries to create a workout without exercises" do
    visit new_workout_path
    fill_in "workout_title", with: @workout_title
    fill_in "workout_instructions", with: @workout_instructions
    click_button("Create Workout")
    page.should have_content("Oops! There are some errors")
  end
  
  describe "index" do

    it "index booking details are correct" do
      @destroy_workout = Factory(:workout, user_id: @trainer.id)
      Factory(:booking, trainer_id: @trainer.id)
      
      sign_in_visit_workouts(@trainer)
      page.should have_content("1 exercise")
      page.should have_content("0 Bookings")

      click_link(@destroy_workout.title.titleize)
      current_path.should eq(workout_path(@destroy_workout))

      visit workouts_path
      click_link("Create Booking")
      current_path.should eq(new_booking_path)

      @booking = Factory(:booking, workout_id: @destroy_workout.id, trainer_id: @trainer.id)
      visit workouts_path
      click_link("1 Booking")
      page.should have_css("h1", "#{@destroy_workout.title.titleize} Bookings")

      visit workouts_path
      click_link("Delete")
      page.should_not have_content(@destroy_workout.title.titleize)
    end

    it "indexes workouts alphabetically" do
      @workout2 = Factory(:workout, title: "CCCCC", user_id: @trainer.id)
      @workout = Factory(:workout, title: "AAAAAA", user_id: @trainer.id)

      # @trainer.workouts.should == [@workout, @workout2] don't know how to test this on the page... come back to it
    end
    
    it "paginates over 10 workouts" do
      30.times do 
        Factory(:workout, user_id: @trainer.id)
      end
    
      integration_sign_in(@trainer)
      visit workouts_path
      page.should have_css("a", text: "3")
    end
  end
  
  describe "does stuff with a created workout" do
    
    before(:each) do
      @exercise = Factory(:exercise, user_id: @trainer.id)
      @workout = Factory(:workout, user_id: @trainer.id, exercise_ids: @exercise.id)
    end
    
    it "visits the workouts page" do
      click_link("Workouts: ")
      click_link(@workout.title)
    end
        
    it "edits a workout" do
      @new_title = "New title yo, cause I'm smooth like that"
      visit workout_path(@workout)
      click_link("Edit")
      fill_in "workout_title", with: @new_title
      click_button("Edit Workout")
      page.should have_content("Workout updated!")
    end
    
    it "deletes a workout" do
      Factory(:workout, user: @trainer, exercise_ids: @exercise.id)
      visit workouts_path
      click_link("Delete")
      page.should have_content("Workout deleted")
      click_link("Delete")
      page.should have_content("You have no workouts")
    end
    
    describe "workouts with exercises" do

      it "adds an exercise to the workout" do
        visit new_workout_path
        fill_in"workout_title", with: @workout_title
        fill_in"workout_instructions", with: @workout_instructions
        check("exercise_#{@exercise.id}")
        click_button("Create Workout")
        page.should have_content("New workout added!")
      end

      it "displays the exercise on the workout page" do
        click_link("Sign Out")
        new_workout(@trainer, @exercise)
        page.should have_css("a", text: @exercise.title)
        page.should have_content(@exercise.body_part)
        page.should have_content(@exercise.equipment)
      end
    end    
  end  
end
