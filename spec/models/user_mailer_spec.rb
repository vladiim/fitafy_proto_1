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
end