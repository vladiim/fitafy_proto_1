source 'http://rubygems.org'

gem 'rails', '~> 3.2.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg', '~> 0.13.0'
gem 'heroku', '~> 2.21.0'
gem 'authlogic', '~> 3.1.0'
gem 'cancan', '~> 1.6.0'
gem 'will_paginate', '~> 3.0.0'
gem 'simple_form', '~> 2.0.0'
gem 'faker', '~> 1.0.0'
gem 'resque', '~> 1.20.0', require: "resque/server"
gem 'resque_mailer', '~> 2.0.0'
gem 'best_in_place', '~> 1.0.0'
gem 'acts_as_list', '~> 0.1.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'haml-rails', '~> 0.3.0'
  gem 'bootstrap-sass', '~> 2.0.1'
  gem 'jquery-rails', '~> 2.0.0'
end

##############TEST SUITE###############

gem 'rspec-rails', :group => [:test, :development]

group :test do
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'capybara', '~> 1.1.0'
  gem 'guard-rspec', '~> 0.6.0'
  gem 'spork', '~> 0.9.0'
  gem 'turn', '0.8.2', :require => false
end
