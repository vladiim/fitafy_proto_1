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
  
  it "adds a new client to the system" do

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