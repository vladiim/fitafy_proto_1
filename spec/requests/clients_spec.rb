require 'spec_helper'

describe "Clients" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
  end
  
  it "trains! and untrains! a client who is in the system" do
    integration_sign_in(@trainer) 
    visit user_path(@client)
    click_button("Add client")
    page.should have_content("Client invited")
    click_button("Remove client")
    page.should have_content("Client removed")
  end
  
  describe "new client" do
    
    before(:each) do
      @client_email = FactoryGirl.generate(:email)
    end
    
    it "invites a new client" do
      integration_sign_in(@trainer)
      click_link "Invite New"
      fill_in "invitation_recipient_email", with: @client_email
      click_button("Invite Client")
      page.should have_content("Client invited!")
      last_email.to.should include(@client_email)
      last_email.body.should include(@trainer.username.titleize)      
    end
    
    it "client creates account from invite" do
      integration_sign_in(@trainer)
      @invitation = @trainer.invitations.create(recipient_email: @client_email)
      click_link "Sign Out"
      visit "/signup/#{@invitation.token}"
      # page.should_not have_content : whatever the default edit content is
      fill_in "user_username",              with: "new_client"
      fill_in "user_password",              with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_button("Create Account")
      page.should have_content("Welcome to fitafy!")
    end
    
    it "finds an exsisting client"
    
    it "creates a booking with a client that hasn't signed up yet"
    
    it "relates a signed up client to bookings already created"
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

    it "creates a booking with a client from their index page" do
      integration_sign_in(@trainer)    
      click_link("Clients: #{@trainer.training.count}")
      click_link("Create Booking")
      # page.select('Client').should have_value("#{@client.unsername}")
    end
    
    describe "client bookings" do
        
      before(:each) do
        @booking = Factory(:booking, client_id: @client.id, trainer_id: @trainer.id, wo_time: "12:00", wo_date: 1.day.from_now)
      end
        
      it "looks at which bookings a client has" do
        integration_sign_in(@trainer)
        click_link("Clients: 1")
        click_link("1 Booking")
        page.should have_content(@booking.booking_time)
        current_path.should eq(user_reverse_bookings_path(@client))
        visit user_path(@client)
        click_link("1 Booking")
        current_path.should eq(user_reverse_bookings_path(@client))
      end
    end
  end
end