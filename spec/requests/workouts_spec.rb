require 'spec_helper'

describe "Workouts" do
  
  before(:each) do
    @trainer = Factory(:user)
    integration_sign_in(@trainer)
    @exercise = Factory(:exercise, user_id: @trainer)
    @workout_title = "Da heaps Hardcore Workout"
    @workout_description = "Not for the feignt hearted"
  end
  
  it "creates a new workout" do
    visit root_path
    click_link("Workouts")
    current_path.should eq(new_workout_path)
    fill_in "workout_title", with: @workout_title
    fill_in "workout_description", with: @workout_description
    check("exercise_#{@exercise.id}")
    click_button("Create Workout")
    page.should have_content("New workout added!")
    page.should have_content("#{@workout_title}")
  end
  
  describe "does stuff with a created workout" do
    
    before(:each) do
      @exercise = Factory(:exercise, user_id: @trainer.id)
      @workout = Factory(:workout, user_id: @trainer.id, exercise_ids: @exercise.id)
    end
    
    it "visits the workouts page" do
      click_link("Workouts")
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
      click_link("Delete Workout")
      page.should have_content("Workout deleted")
      click_link("Delete Workout")
      page.should have_content("You have no workouts")
    end
    
    describe "workouts with exercises" do
      
      before(:each) do
        @exercise = Factory(:exercise)
      end
      
      it "adds an exercise to the workout" do
        visit new_workout_path
        fill_in"workout_title", with: @workout_title
        fill_in"workout_description", with: @workout_description               
        check("exercise_#{@exercise.id}")
        click_button("Create Workout")
        page.should have_content("New workout added!")        
        page.should have_content(@exercise.title)
      end
      
      it "displays the exercise on the workout page" do
        click_link("Sign Out")
        new_workout(@trainer, @exercise)
        page.should have_css("a", text: @exercise.title)
        page.should have_content(@exercise.body_part)
      end
      
      describe "workout with bookings" do
        
        before(:each) do
          @client = new_client
          @booking = Factory(:booking, workout_id: @workout.id, trainer: @trainer, client: @client)
        end
        
        it "should have the booking number on the workout show page" do
          visit workout_path(@workout)
          click_link("1 Booking")
          current_path.should eq(workout_bookings_path(@workout))
        end
      end
    end    
  end  
end
