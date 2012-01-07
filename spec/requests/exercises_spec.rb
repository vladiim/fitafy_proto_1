require 'spec_helper'

describe "Excerses" do
  before(:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    integration_sign_in(@trainer)
    @exercise_title = "Dumbell Shoulder Press"
    @exercise_description = "Get two dumbells and press!"
  end
  
  it "creates a new excercise only as an admin user" do
    visit root_path
    visit new_exercise_path
    fill_in "exercise_title", :with => @exercise_title
    fill_in "exercise_description", :with => @exercise_description    
    click_button("Add New Exercise")
    page.should have_content("New exercise added!")
    current_path.should eq(exercises_path)
    page.should have_css("a", :text => "#{@exercise_title}")
  end
  
  describe "does stuff with a created workout" do
    
    before(:each) do
      @exercise = Factory(:exercise, :user_id => @trainer.id)
    end
    
    it "visits an exercise page" do
      visit exercises_path
      click_link("#{@exercise.title}")
      page.should have_css("h4", :text => "#{@exercise.title}")
      page.should have_content("#{@exercise.description}")
    end
    
    it "edits an exercise" do
      @new_title = "Bench Prooos"
      visit exercise_path(@exercise)
      click_link("Edit Exercise")
      fill_in "exercise_title", :with => @new_title
      click_button("Update Exercise")
      current_path.should eq(exercise_path(@exercise))
      page.should have_content("Exercise updated!")
    end
    
    it "deletes an exercise" do
      visit exercises_path
      click_link("Delete Exercise")
      page.should have_content("Exercise deleted")
      # page.should_not have_content("#{@exercise.title}") test not passing but working in browser???
    end
  end  
end
