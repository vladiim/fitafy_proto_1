require 'spec_helper'

describe "Clients" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
  end
  
  describe "creating a relationship with a client" do
    
    it "trains! and untrains! a client" do
      integration_sign_in(@trainer) 
      visit user_path(@client)
      click_button("Add Client")
      page.should have_content("Client invited")
      click_button("Remove Client")
      page.should have_content("Client removed")    
    end
    
    describe "trainer invites client already in the system" do
      
      before(:each) do
        trains_client(@trainer, @client)
        click_link "Sign Out"    
      end
      
      it "should send an invite to the client" do
        last_email.to.should include(@client.email)
        last_email.body.should include(@trainer.username.titleize)
        last_email.body.should include("#{invites_path}")  
      end
      
      it "client visits /invites and accepts" do
        integration_sign_in(@client)
        visit invites_path
        page.should have_css("h1", text: "Invites")
        page.should have_css("a", text: @trainer.username.titleize)
        check('relationship_accepted')
        click_button("Save")
        page.should have_content("Invite accepted!")
        # with no invites it should redirect to the home page
        current_path.should eq(root_path)
      end
      
      it "client visits /invites and declines" do
        integration_sign_in(@client)
        visit invites_path
        check('relationship_declined')        
        click_button("Save")
        page.should have_content("Invite declined.")
        # with no invites it should redirect to the home page
        current_path.should eq(root_path)
      end
    end    
  end
  
  describe "index" do
    
    it "redirects you if you have no clients" do
      integration_sign_in(@trainer)
      click_link("Clients: ")
      current_path.should eq(new_client_path)
      page.should have_content("You have no clients, why not invite some?")
    end
    
    it "index client details are correct" do
      @trainer.train!(@client)
      integration_sign_in(@trainer)
      click_link("Clients: ")

      page.should have_content("0 Bookings")

      click_link(@client.username.titleize)
      current_path.should eq(user_path(@client))

      @booking = Factory(:booking, trainer_id: @trainer.id, client_id: @client.id, last_message_from: @trainer.id,)
      click_link("Clients: ")
      click_link("1 Booking")
      page.should have_css("h1", text: "Bookings for #{@client.username.titleize}")

      click_link("Clients: ")
      click_link("Create Booking")
      current_path.should eq(new_booking_path)

      click_link("Clients: ")
      click_button("Remove Client")
      page.should_not have_css("a", text: @client.username.titleize)
    end

    it "indexes clients by their name" do
      @client2 = Factory(:client, username: "CCCCC")
      @trainer.train!(@client2)
      @client = Factory(:client, username: "AAAAAA")
      @trainer.train!(@client)

      # @trainer.training.should == [@client, @client2, @client3, @client4] don't know how to test this on the page... come back to it
    end
    
    it "paginates more than 10 clients" do
      30.times do |client|
        @client = Factory(:client)
        @trainer.train!(@client)
      end
      
      integration_sign_in(@trainer)
      click_link("Clients: ")
      page.should have_css("a", text: "3")
    end
  end
  
  describe "trainer invites a client who isn't in the system" do
    
    before(:each) do
      @client_email = "new_client@email.com"
    end
    
    it "invites a new client generating an email invite" do
      integration_sign_in(@trainer)
      click_link("Invite New")
      fill_in "client_email", with: @client_email
      click_button("Invite New Client")
      last_email.to.should include(@client_email)
      last_email.body.should include(@trainer.username.titleize)
    end
    
    it "client visits the link in the email and edits their user account" do
      invite_new_client(@trainer, @client_email)
      @new_client = User.find_by_email(@client_email)
      last_email.body.should include("has invited you to join fitafy")      
      last_email.body.should include(@new_client.perishable_token)
      visit edit_client_path(@new_client.perishable_token)
      fill_in "user_username",              with: "testy_la_roo"
      fill_in "user_password",              with: "password"
      fill_in "user_password_confirmation", with: "password"      
      click_button "Complete Your Profile"
      page.should have_content("Welcome to fitafy")
      page.should have_css("a", "Trainer: 1")
    end
  end
  
  describe "exsisting client" do
  
    before(:each) do
      @trainer.train!(@client)
    end
  
    it "views a list of the trainer's clients" do  
      integration_sign_in(@trainer)    
      click_link("Clients: #{@trainer.training.count}")
      current_path.should eq(training_user_path(@trainer))
      page.should have_css("a", text: "#{@client.username.titleize}")     
    end
  end
end