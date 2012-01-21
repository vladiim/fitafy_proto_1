require 'spec_helper'

describe "Excerses" do
  before(:each) do
    @admin = new_admin
  end
  
  it "creates a new excercise only as an admin user" do
    create_exercise(@admin)
    page.should have_content("New exercise added!")
    visit exercises_path
    page.should have_css("a", :text => "#{@exercise_title}")
  end
  
  describe "does stuff with a created exercise" do
    
    before(:each) do
      @trainer = new_trainer      
      @exercise = Factory(:exercise, :user_id => @admin.id)
    end
    
    it "visits an exercise page as a trainer" do
      integration_sign_in(@trainer)
      visit exercises_path
      click_link("#{@exercise.title}")
      page.should have_css("h2", :text => "#{@exercise.title}")
      page.should have_content("#{@exercise.description}")
    end
    
    it "edits an exercise as an admin" do
      @new_title = "Bench Prooos"
      integration_sign_in(@admin)
      visit exercises_path
      click_link("Edit Exercise")
      fill_in "exercise_title", :with => @new_title
      click_button("Update Exercise")
      current_path.should eq(exercise_path(@exercise))
      page.should have_content("Exercise updated!")
      click_link("Edit Exercise")
      current_path.should eq(edit_exercise_path(@exercise))
    end
    
    it "can't edit an exercise as a trainer" do
      integration_sign_in(@trainer)
      visit edit_exercise_path(@exercise)
      page.should have_content("Sorry! You can't access that page")
    end
    
    it "deletes an exercise as an admin" do
      integration_sign_in(@admin)      
      visit exercises_path
      click_link("Delete Exercise")
      page.should have_content("Exercise deleted")
    end
  end  
end
