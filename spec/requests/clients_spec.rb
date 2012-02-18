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
        last_email.body.should include(@trainer.username)
        last_email.body.should include("#{invites_path}")  
      end
      
      it "client visits /invites and accepts" do
        integration_sign_in(@client)
        visit invites_path
        page.should have_css("h2", text: "Invites")
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
  
  describe "trainer invites a new client" do
    
    before(:each) do
      @client_email = "new_client@email.com"
    end
    
    it "invites a new client generating an email invite" do
      integration_sign_in(@trainer)
      click_link("Invite New")
      fill_in "client_email", with: @client_email
      click_button("Invite New Client")
      last_email.to.should include(@client_email)
      last_email.body.should include(@trainer.username)
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