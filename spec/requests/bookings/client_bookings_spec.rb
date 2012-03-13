# require 'spec_helper'
# 
# describe "client bookings" do
#   
#   before(:each) do
#     @trainer = Factory(:trainer)
#     @client = Factory(:client)
#     @trainer.train!(@client)
#     integration_sign_in(@client)
#   end
#   
#   describe "have no bookings" do
#     
#     it "client visiting bookings_path gets redirected with the client message" do
#       click_link("Bookings: 0")
#       current_path.should eq(new_booking_path)
#     end
#     
#     describe "create booking details" do
#       
#       before(:each) do
#         click_link("Create Booking")
#       end
#       
#       it "new booking auto selects the trainer if there's only one trainer" do
#         page.should have_content(@trainer.username.titleize)
# 
#         page.should_not have_css("label", text: "Workout")
#         page.should_not have_css("label", text: "Message")
#         page.should_not have_css("label", text: "Instructions")
#         
#         fill_in "booking_wo_date",   with: "#{1.day.from_now}"
#         click_button("Request Booking")
#         page.should have_content("Booking requested, your trainer will confirm the time")
#         current_path.should eq(bookings_path)
#       end
# 
#       it "gives a selection if there's more than one trainer" do
#         @trainer2 = Factory(:trainer)
#         @trainer2.train!(@client)
#     
#         select(@trainer2.username, from: "booking_trainer_id")
#       end
#       
#       describe "booking emails" do
#         
#         it "sends an email to the trainer to confirm the booking"
#     
#         it "trainer approves the booking, sends an email back"
#     
#         it "trainer declines the booking, sends an email back"
#     
#         it "trainer suggests a new time for the booking, sends email back"
#       end
#     end
#   end
# end