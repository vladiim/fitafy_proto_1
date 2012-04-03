require 'spec_helper'

describe "Index Trainer Relationships" do

  before(:each) do
    @trainer = Factory(:trainer)
    integration_sign_in(@trainer)
  end

  describe "no clients" do

    it "redirects you if you have no clients" do
      click_link("Clients: ")
      current_path.should eq(new_client_path)
      page.should have_content("Your only client is you! Why not invite some clients you can make money from?")
    end
  end

  describe "with clients" do

    before(:each) do
      @client = Factory(:client)
      @trainer.train!(@client)
      click_link("Clients: ")
    end

    it "lists your bookings with the client" do
      page.should have_content("0 Bookings")
    end

    it "links to the client's bookings if they exsist" do
      @booking = Factory(:booking, trainer_id: @trainer.id, client_id: @client.id, last_message_from: @trainer.id,)
      click_link("Clients: ")
      click_link("1 Booking")
      page.should have_css("h1", text: "Bookings for #{@client.username.titleize}")
    end

    it "doesn't list another trainer's bookings with the client"

    it "links to the client's profile page" do
      click_link(@client.username.titleize)
      current_path.should eq(user_path(@client))
    end

    it "links to new_booking_path" do
      click_link("Create Booking")
      current_path.should eq(new_booking_path)
    end

    it "can remove client from the index page" do
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
        client = Factory(:client)
        @trainer.train!(client)
      end

      click_link("Clients: ")
      page.should have_css("a", text: "3")
    end
    
  end
end
