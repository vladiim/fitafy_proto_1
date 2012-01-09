# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Fitafy::Application.initialize!

Time::DATE_FORMATS[:booking_title] = "Booking on %A %e %b at %I:%M %p"