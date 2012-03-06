require 'spec_helper'
require "cancan/matchers"

describe UserMailer do
  
  def with_stub_const(const, value) # http://stackoverflow.com/questions/7847982/stubbing-mocking-global-constants-in-rspec
    if Object.const_defined?(const)
      begin
        @const = const
        Object.const_set(const, value)
        yield
      ensure
        Object.const_set(const, @const)
      end
    else
      begin
        Object.const_set(const, value)
        yield
      ensure
        Object.send(:remove_const, const)
      end
    end
  end
  
  describe "development" do
    
    before(:each) do
      @trainer = Factory(:trainer)
    end
    
    it "should have fitafy.com as the default host" # do
    #       
    #       # ENV['RAILS_ENV'] = 'production' 
    #       Rails.env = ActiveSupport::StringInquirer.new('production')
    #       UserMailer.password_reset(@trainer).deliver
    #       # rails = double('Rails', env: "production")
    #       #       @prod_mailer = UserMailer.with_stub_const(:Rails, rails) 
    #       #       @prod_mailer.password_reset(@trainer).deliver
    #             
    #       
    #       last_email.body.should include("fitafy.com")
    # end
  end
end