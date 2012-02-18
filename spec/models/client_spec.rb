require 'spec_helper'

describe Client do
  
  describe "validations" do
    
    before(:each) do
      @trainer = Factory(:trainer)
      @client = Factory(:client)
    end
    
    it "validates presence of email" do
      @client = Client.new(email: "")
      @client.should be_invalid
    end
    
    it "validates uniqueness of email" do
      @client = Client.new(email: @client.email)
      @client.should be_invalid
    end
  end
end