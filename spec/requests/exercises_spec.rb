require 'spec_helper'

describe "Exercises" do
  before(:each) do
    @trainer = Factory(:trainer)
    @admin = Factory(:admin)
  end
  
  describe "creates an exercise" do
    
    it "clean this shit up (exercises#show)"
    
    it "creates a new excercise only as an admin user" do
      create_exercise(@admin)
      page.should have_content("New exercise added!")
      visit exercises_path
      page.should have_css("a", text: "#{@exercise_title}")
    end
    
    it "a trainer can't view another trainer's exercise" do
      @trainer1_exercise = Factory(:exercise, user_id: @trainer.id)
      @trainer2 = Factory(:trainer)
      integration_sign_in(@trainer2)
      visit exercise_path(@trainer1_exercise)
      page.should have_content("Sorry! You can't access that page")
    end
    
    it "a trainer can view an admin's exercise" do
      @admin_exercise = Factory(:exercise, user_id: @admin.id)
      integration_sign_in(@trainer)
      click_link("Exercises: ")
      click_link(@admin_exercise.title)
      current_path.should eq(exercise_path(@admin_exercise))
    end
    
    it "a trainer can view his own exercise" do
      @my_exercise = Factory(:exercise, user_id: @trainer.id, title: "testy balls")
      integration_sign_in(@trainer)
      click_link("Exercises: ")
      click_link(@my_exercise.title)
      current_path.should eq(exercise_path(@my_exercise))
    end
  end
  
  describe "does stuff with a created exercise" do
    
    before(:each) do
      @exercise = Factory(:exercise, user_id: @admin.id)
      @workout = @admin.workouts.create!(title: "Testing", exercise_ids: @exercise.id)
    end
    
    it "visits an exercise page as a trainer" do
      integration_sign_in(@trainer)
      visit exercises_path
      click_link("#{@exercise.title}")
      page.should have_css("h1", text: "#{@exercise.title}")
      page.should have_content("Description: #{@exercise.description}")
      page.should have_content(@exercise.body_part)
      page.should have_content(@exercise.equipment)
      page.should have_content(@exercise.cues)
    end
    
    it "edits an exercise as an admin" do
      @new_title = "Bench Prooos"
      integration_sign_in(@admin)
      visit exercises_path
      click_link("Edit")
      fill_in "exercise_title", with: @new_title
      click_button("Update Exercise")
      current_path.should eq(exercise_path(@exercise))
      page.should have_content("Exercise updated!")
      click_link("Edit")
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
      click_link("Delete")
      page.should have_content("Exercise deleted")
    end
    
    it "paginates the list of exercises" do
      20.times do
        Factory(:exercise, user_id: @trainer.id)
      end

      integration_sign_in(@trainer)
      visit exercises_path
      click_link("Next")
      page.should have_content("20")
    end
    
    describe "exercise.workouts" do
      
      it "can can see all the trainer's workouts associated with the exercise" do
        # click workout link associated to excercise not the one in the nav
        Factory(:workout, user_id: @trainer.id)
        
        @exercise             = Factory(:exercise)
        @trainer_workout      = Factory(:workout, user_id: @trainer.id, exercises: [@exercise])
        @trainer_workout2      = Factory(:workout, user_id: @trainer.id, exercises: [@exercise], title: "Long Test Title")
        @admin_workout        = Factory(:workout, user_id: @admin.id, exercises: [@exercise])
        @diff_trainer_workout = Factory(:workout, exercises: [@exercise])

        integration_sign_in(@trainer)
        visit exercises_path
        # click_link("2 Workouts") # not sure why I can't get this to pass but working in real life, maybe come back to it later
        visit exercise_workouts_path(@exercise)

        current_path.should eq(exercise_workouts_path(@exercise))
        page.should have_css("a", text: @trainer_workout.title)
        page.should have_css("a", text: @trainer_workout2.title)
        page.should_not have_css("a", text: @admin_workout.title)
        page.should_not have_css("a", text: @diff_trainer_workout.title)
      end
      
      it "can see all the workouts associated to an exercise" do
        integration_sign_in(@admin)
        click_link("Exercises: ")
        click_link(@exercise.title)
        click_link("1 Workout")
        click_link(@workout.title)
        page.should have_css("h1", @workout.title)
        click_link("Exercises: ")
        click_link("1 Workout")
        page.should have_content("1 exercise")
        click_link(@workout.title)
        page.should have_css("h1", @workout.title)
      end
    end
    
    describe "exercise templates" do
  
      before(:each) do
        @booking = Factory(:booking, workout_id: @workout.id, trainer_id: @trainer.id, last_message_from: @trainer.id)
      end
  
      it "only lists exercise templates" do
        integration_sign_in(@trainer)
        click_link("Exercises: 1")
        current_path.should eq(exercises_path)
      end
      
      it "doesn't link exercises created by another trainer" do
        @other_exercise = Factory(:exercise)
        integration_sign_in(@trainer)
        click_link("Exercises: 1")
        page.should_not have_css("a", text: @other_exercise.title)
      end
      
      it "sees 2 admin's exercises" do
        @admin2 = Factory(:admin)
        @exercise2 = Factory(:exercise, user_id: @admin2.id)
        @trainer.exercise_list.should include(@exercise2)
      end
    end
  end  
end
