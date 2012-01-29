require 'spec_helper'

describe "Abilities" do
  
  describe "admin" do
    
    before(:each) do
      @admin = Factory(:admin)
      @title = "Shoulddddr"
      @description = "Push da shouldrrrr mon!"
    end
    
    it "admin should have exercise and shouldn't have contact in their navigation" do
      integration_sign_in(@admin)
      page.should_not have_css("a", text: "Contact")
      page.should have_css("a", text: "Exercises")
    end
    
    it "admin should be able to create exercises" do
      create_exercise(@admin)
      page.should have_content("New exercise added!")
    end
  end
  
end