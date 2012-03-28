class Bookings::Requests::EditPresenter

  def initialize(booking)
    @booking = booking
  end

  def booking
    @booking
  end

  def title
    @title = "Suggest New Time"
  end

  def client
    @client = Client.new
  end
end