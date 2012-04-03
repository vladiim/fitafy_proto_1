require 'spec_helper'

describe "Create Relationship" do

  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    integration_sign_in(@trainer)
  end

  describe "creating a client relationship with an exsisting member of fitafy" do

    it "trains! and untrains! a client" do
      visit user_path(@client)
      click_button("Add Client")
      page.should have_content("Client invited")
      click_button("Remove Client")
      page.should have_content("Client removed")    
    end
  end

  describe "creating a client relationship with a non-member of fitafy" do

    before(:each) do
      @client_email = "new_client@email.com"
    end

    it "invites a new client generating an email invite" do
      click_link("Create Booking")
      click_link("Invite New")
      fill_in "client_email", with: @client_email
      click_button("Invite New Client")
      last_email.to.should include(@client_email)
      last_email.body.should include(@trainer.username.titleize)
    end
  end

  describe "after invite created" do

    before(:each) do
      @trainer.train!(@client)
    end

    describe "relationship emails sent" do

      it "should send an invite to the client" do
        last_email.to.should include(@client.email)
        last_email.body.should include(@trainer.username.titleize)
        last_email.body.should include("#{invitations_path}")
      end
    end

    describe "list my invites to a client" do

      before(:each) do
        visit invitations_path
      end

      it "lists all my clients from the relationships path" do
        current_path.should eq(invitations_path)
        page.should have_css("a", @client.username)
      end

      it "should give details about the invitation" do
        page.should have_content("You asked")
        page.should have_content("to be your client")
      end

      it "allows me to cancel the invite" do
        click_button("Retract Client Invitation")
        page.should have_content("Client removed.")
      end
    end
  end

  describe "client invites trainer" do

    before(:each) do
      @trainer2 = Factory(:trainer)
      visit user_path(@trainer2)
      click_button("Add Trainer")
      click_link("Sign Out")
      integration_sign_in(@trainer2)
    end

    it "sign in flash when client invites trainer" do
      page.should have_content("You have new invites from clients who want you to train them!")
    end

    it "sign in flash shouldn't be there if there are no client invites" do
      accept_relationship
      click_link("Sign Out")
      integration_sign_in(@trainer2)

      page.should_not have_content("You have new invites from clients who want you to train them!")
    end

    it "should redirect from invitations to the homepage if they have no invites" do
      accept_relationship
      visit invitations_path
      current_path.should eq(root_path)
      page.should have_content("You haven't got any invites")
    end

    it "should show a double message if they have client and trainer invites"

    it "should not show the client flash message" do
      page.should_not have_content("You have new invites from trainers who want you as a client")
    end
  end
end