require 'spec_helper'

describe Invitation do
  
  before(:each) do
    @trainer = Factory(:user)
    @invitation = Factory(:invitation)
    @recipient_email = "user@email.com" 
  end
  
  it "should generate a token before creating" do
    @token_check = Invitation.create(recipient_email: @recipient_email, trainer_id: @trainer.id)
    @token_check.token.should be_present
  end
  
  it "creates a new user with invited_role" do
    client = User.find_by_email(@invitation.recipient_email)
    client.username.should eq(@invitation.recipient_email)
    client.role.should eq("invited_role")
  end
  
  describe "associations" do
    
    it "should respond to sender" do
      @invitation.should respond_to(:trainer)
    end
    
    it "should respond to recipient" do
      @invitation.should respond_to(:recipient)
    end
  end
  
  describe "validations" do
    
    it "validates the presence of recipient_email" do
      @bad_invite = Factory.build(:invitation, recipient_email: "")
      @bad_invite.should be_invalid
    end
    
    it "validates that the recipient_is_not_registered" do
      @client = Factory(:client)
      @exsisting_client = Factory.build(:invitation, recipient_email: @client.email)
      @exsisting_client.should be_invalid
    end
  end
end
