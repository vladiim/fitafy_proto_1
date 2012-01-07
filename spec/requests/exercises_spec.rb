require 'spec_helper'

describe "Excerses" do
  before(:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    integration_sign_in(@trainer)
    @excercise_title = "Dumbell Shoulder Press"
    @excercise_description = "Get two dumbells and press!"
  end
  
  it "creates a new excercise only as an admin user" do
    visit root_path
    visit new_exercise_path
    fill_in "excercises_title", :with => @excercise_title
    fill_in "excercises_description", :with => @excercise_description    
    click_link("Add excercise")
    page.should have_content("New excercise added!")
    current_path.should eq(excersises_path)
    page.should have_css("a", :text => "#{@excercise_title}")
  end
  
  describe "does stuff with a created workout" do
    
    before(:each) do
      @workout = Factory(:workout, :user_id => @trainer.id)
    end
    
  #   it "visits an exercise page" do
  #     visit exercises_path
  #     click_link("#{@excercise.title}")
  #     page.should have_css("h4", :text => "#{@workout.title}")
  #     page.should have_content("#{@workout.description}")
  #   end
  #   
  #   it "edits a workout" do
  #     @new_title = "New title yo, cause I'm smooth like that"
  #     visit workout_path(@workout)
  #     click_link("Edit Workout")
  #     fill_in "workout_title", :with => @new_title
  #     click_button("Update Workout")
  #     current_path.should eq(workout_path(@workout))
  #     page.should have_content("Workout updated!")
  #   end
  #   
  #   it "deletes a workout" do
  #     visit workouts_path
  #     click_link("Delete Workout")
  #     page.should have_content("Workout deleted")
  #     page.should_not have_content("#{@workout.title}")
  #   end
  end  
end
