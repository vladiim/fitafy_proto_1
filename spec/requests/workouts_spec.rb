require 'spec_helper'

describe "Workouts" do
  
  before(:each) do
    @trainer = new_trainer
    integration_sign_in(@trainer)
    @workout_title = "Da heaps Hardcore Workout"
    @workout_description = "Not for the feignt hearted"
  end
  
  it "creates a new workout" do
    visit root_path
    click_link("Workouts")
    current_path.should eq(new_workout_path)
    fill_in "workout_title", :with => @workout_title
    fill_in "workout_description", :with => @workout_description
    click_button("Create Workout")
    page.should have_content("New workout added!")
    current_path.should eq(workouts_path)
    page.should have_content("#{@workout_title}")
  end
  
  describe "does stuff with a created workout" do
    
    before(:each) do
      @workout = Factory(:workout, :user_id => @trainer.id)
    end
    
    it "visits the workouts page" do
      click_link("Workouts")
      click_link(@workout.title)
    end
        
    it "edits a workout" do
      @new_title = "New title yo, cause I'm smooth like that"
      visit workout_path(@workout)
      click_link("Edit Workout")
      fill_in "workout_title", :with => @new_title
      click_button("Edit Workout")
      page.should have_content("Workout updated!")
    end
    
    it "deletes a workout" do
      Factory(:workout, :user => @trainer)
      visit workouts_path
      click_link("Delete Workout")
      page.should have_content("Workout deleted")
      click_link("Delete Workout")
      page.should have_content("You have no workouts")
    end
    
    it "creates a booking from the workout page" 
  end  
end
