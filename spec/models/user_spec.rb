require 'spec_helper'

describe User do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:user)
    @trainer.train!(@client)
  end
  
  it "should be training? a trained! @client" do
    @trainer.should be_training(@client)
  end
  
  it "should not be training? an untrained! client" do
    @trainer.untrain!(@client)
    @trainer.should_not be_training(@client)
  end
  
  it "clients should be trained_by a trainer" do
    @client.should be_trained_by(@trainer)
  end
end
