require 'spec_helper'

describe Relationship do
  
  describe "trainer initiated relationships" do

    before(:each) do
      @trainer = Factory(:user)
      @client = Factory(:client)
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
    
      it "should default :accepted to false" do
        @relationship.accepted.should eq(false)
      end
    
      it "should have a scope that checks if a relationship has been accepted" do
        @relationship.should respond_to(:accepted)
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
    
      it "can't destroy a relationship where the same person is the trainer & client" do
        @non_destroy_relationship = @trainer.relationships.find_by_client_id(@trainer.id)
        @non_destroy_relationship.destroy.should eq(false)
      end
    end
  end

  describe "client initiated" do
    it "write some tests for when clients invite trainers"
  end
end