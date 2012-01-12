# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Fitafy::Application.initialize!

# # Accept dates Yank style
# my_date_formats = { :default => '%m/%d/%Y' } 
# Time::DATE_FORMATS.merge!(my_date_formats) 
# Date::DATE_FORMATS.merge!(my_date_formats)