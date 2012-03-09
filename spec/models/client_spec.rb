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
  
  describe "creation" do
    it "should set the role as client_role after the user is invited" do
      @invited = Factory(:invited)
      @invited.update_attributes(username: "new yo mo fo")
      @invited.role.should eq("client_role")
    end
  end
end