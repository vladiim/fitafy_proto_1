class AsyncMailer < ActionMailer::Base
  
  include Resque::Mailer
  
  Resque::Mailer.excluded_environments = [:test, :rspec]
end