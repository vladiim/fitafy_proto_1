class Bookings::MasterPresenter

  def initialize(user, booking_id=nil)
    @user = user
    @booking_id = booking_id

    # be able to create bookings#new/show
    if @booking_id == nil
      @booking = Booking.new
      @client = Client.new
    else
      @booking = @user.bookings.find(booking_id)
      @client = User.find(@booking.client_id)
    end
  end

  def workout
    @workout = @booking.workout
  end

  def exercises
    @exercises = @booking.exercises
  end

  def booking
    @booking
  end

  def client
    @client
  end

  def show_title
    @title = "Booking for: #{@client.username}"
  end

  def edit_title
    @title = "Edit Booking"
  end

  def instructions
    @booking.instructions
  end
end