module BookingsHelper
  
  def booking_date(booking)
    booking.wo_date.strftime("%A %e %b")
  end
  
  def booking_time(booking)
    booking.wo_time.strftime("%I:%M %p")
  end
  
end
