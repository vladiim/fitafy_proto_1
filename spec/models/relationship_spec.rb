require 'spec_helper'

describe Relationship do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:user)
    @relationship = @trainer.relationships.build(client_id: @client.id)
  end
  
  it "should create a new relationship" do
    @relationship.save!
  end
  
  describe "creating a relationship" do
    
    before(:each) do
      @relationship.save
    end
    
    it "should have the right trainer attribute" do
      @relationship.trainer.should eq(@trainer)
    end
    
    it "should have the right client attribute" do
      @relationship.client.should eq(@client)
    end
  end
  
  describe "validations" do
    it "should require a trainer_id" do
      @relationship.trainer_id = nil
      @relationship.should be_invalid
    end
    
    it "should require a client_id" do
      @relationship.client_id = nil
      @relationship.should be_invalid
    end
  end
  
end
