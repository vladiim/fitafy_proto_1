describe Bookings::MasterPresenter do
  
  before(:each) do
    @trainer = Factory(:user)
    @booking = Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id)
    @presenter = Bookings::MasterPresenter.new(@trainer, @booking.id)
  end
  
  it "should respond to booking" do
    @presenter.should respond_to(:booking)
  end
  
  it "should respond to workout" do
    @presenter.should respond_to(:workout)
  end
  
  it "should respond to exercises" do
    @presenter.should respond_to(:exercises)
  end
  
  it "should respond to client" do
    @presenter.should respond_to(:client)
  end
  
  it "should respond to title" do
    @presenter.should respond_to(:show_title)
  end

  it "should respond to title" do
    @presenter.should respond_to(:edit_title)
  end
end