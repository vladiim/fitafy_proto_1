require 'spec_helper'

describe "Manage Invites" do

  before(:each) do
    @trainer = Factory(:trainer)
  end

  describe "brand new to fitafy" do

    before(:each) do
      @client_email = "new_client@email.com"
    end

    it "client visits the link in the email and edits their user account" do
      invite_new_client(@trainer, @client_email)
      @new_client = User.find_by_email(@client_email)
      visit edit_client_path(@new_client.perishable_token)
      fill_in "user_username",              with: "testy_la_roo"
      fill_in "user_password",              with: "password"
      fill_in "user_password_confirmation", with: "password"      
      click_button "Complete Your Profile"
      page.should have_content("Welcome to fitafy")
      page.should have_css("a", "Trainer: 1")
    end
  end

  describe "exsisting fitafy user" do

    before(:each) do
      @client = Factory(:client)
      @trainer.train!(@client)
      integration_sign_in(@client)
    end

    describe "client invite flash" do

      it "sign in flash when trainer invites client" do
        page.should have_content("You have new invites from trainers who want you as a client")
      end

      it "should not show the trainer's flash message" do
        page.should_not have_content("You have new invites from clients who want you to train them!")
      end
    end

    describe "accepts/declines from invite path" do

      it "client visits /invites and accepts" do
        accept_relationship
        page.should have_content("Invite accepted!")

        # with no invites it should redirect to the home page
        current_path.should eq(root_path)
        page.should have_content("You haven't got any invites")
      end

      it "client visits /invites and declines" do
        decline_relationship
        page.should have_content("Invite declined.")

        # with no invites it should redirect to the home page
        current_path.should eq(root_path)
        page.should have_content("You haven't got any invites")
      end
    end

    describe "accepts/declineds from trainer's profile page" do

      it "accepts from trainer's profile page"

      it "declines from trainer's profile page"

      it "bug: trainer invites client, when client goes to /invitations they see their name in the invite not the trainers"

      it "bug: it auto shows trainers even when they're not accepted" do
        
      end
    end
  end
end