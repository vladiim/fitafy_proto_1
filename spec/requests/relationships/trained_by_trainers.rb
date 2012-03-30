require 'spec_helper'

describe "Trainers" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
  end
  
  describe "creating a relationship with a client" do
    
    
    #####   THE CODE BELOW HAS BEEN COPIED FROM TRAINING CLIENTS AND NEEDS TO BE CHANGED FOR TRAINERS
    
    # it "trains! and untrains! a client" do
    #   integration_sign_in(@trainer) 
    #   visit user_path(@client)
    #   click_button("Add Client")
    #   page.should have_content("Client invited")
    #   click_button("Remove Client")
    #   page.should have_content("Client removed")    
    # end
    #   describe "client invites trainer" do
    # 
    #     before(:each) do
    #       @trainer2 = Factory(:trainer)
    #       visit user_path(@trainer2)
    #       click_button("Add Trainer")
    #       click_link("Sign Out")
    #       integration_sign_in(@trainer2)
    #     end

        it "sign in flash when client invites trainer" do
          page.should have_content("You have new invites from clients who want you to train them!")
        end

        it "sign in flash shouldn't be there if there are no client invites" do
          visit invites_path
          check('relationship_accepted')
          click_button("Save")
          click_link("Sign Out")
          integration_sign_in(@trainer2)

          page.should_not have_content("You have new invites from clients who want you to train them!")
        end

        it "should show a double message if they have client and trainer invites"

        it "should not show the client flash message" do
          page.should_not have_content("You have new invites from trainers who want you as a client")
        end
      end
    end
  end
end