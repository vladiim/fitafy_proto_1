class Bookings::MasterPresenter

  def initialize(user, booking_id)
    @user = user
    @booking_id = booking_id
    @booking = @user.bookings.find(booking_id)
    @client = User.find(@booking.client_id)
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