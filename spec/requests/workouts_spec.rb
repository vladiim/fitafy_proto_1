require 'spec_helper'

describe "Workouts" do
  
  before(:each) do
    @trainer = new_trainer
    integration_sign_in(@trainer)
    @workout_title = "Da heaps Hardcore Workout"
    @workout_description = "Not for the feignt hearted"
    @exercise = Factory(:exercise, :user_id => @trainer.id)    
  end
  
  it "creates a new workout and adds and excercise" do
    visit root_path
    click_link("Workouts")
    click_link("Create Workout")
    fill_in "workout_title", :with => @workout_title
    fill_in "workout_description", :with => @workout_description
    check("#{@exercise.title}") 
    click_button("Create Workout")
    page.should have_content("New workout added!")
    current_path.should eq(workouts_path)
    click_link("#{@workout_title}")
    page.should have_content("#{@exercise.title}")
  end
  
  describe "does stuff with a created workout" do
    
    before(:each) do
      @workout = Factory(:workout, :user_id => @trainer.id)
    end
    
    it "visits a workout page" do
      visit workouts_path
      click_link("#{@workout.title}")
      page.should have_css("h4", :text => "#{@workout.title}")
      page.should have_content("#{@workout.description}")
    end
    
    it "edits a workout" do
      @new_title = "New title yo, cause I'm smooth like that"
      visit workout_path(@workout)
      click_link("Edit Workout")
      fill_in "workout_title", :with => @new_title
      click_button("Update Workout")
      current_path.should eq(workout_path(@workout))
      page.should have_content("Workout updated!")
    end
    
    it "deletes a workout" do
      visit workouts_path
      click_link("Delete Workout")
      page.should have_content("Workout deleted")
      page.should_not have_content("#{@workout.title}")
    end
  end  
end
