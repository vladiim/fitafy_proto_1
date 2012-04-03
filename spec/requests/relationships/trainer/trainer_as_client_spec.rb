require 'spec_helper'

describe "Trainer as Client" do

  before(:each) do
    @trainer = Factory(:trainer)
    Factory(:admin)
    @new_trainer = Factory(:trainer)
    @new_trainer.train!(@trainer)
    integration_sign_in(@trainer)
    click_link ("Trainers:")
  end

  it "should be able to get rid of another trainer but not themself" do
    click_button("Remove Trainer")
    visit trained_by_user_path(@trainer)

    # page.should_not have_css("a", text: @new_trainer.username.titelize)
    # page.should have_css("a", text: @trainer.username.titelize)
    page.should_not have_css("input", text: "Remove Trainer")
  end
end