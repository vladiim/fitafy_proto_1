require "authlogic/test_case"
include Authlogic::TestCase

FactoryGirl.define do
  
  sequence :username do |n|
    "user#{n}"
  end
  
  sequence :title do |n|
    "I'm The #{n} Badass Tittle"
  end
  
  sequence :description do |n|
    "I'm The #{n} Badass Description"
  end
  
  sequence :equipment do |n|
    "#{n} Equipment"
  end
  
  factory :user do 
    username    { FactoryGirl.generate(:username) }
    email       { "#{username}@email.com"}
    password    "password"
    password_confirmation "password"
    role        "trainer_role"
    admin       false
    
    factory :client do
      role      "client_role"
    end
    
    factory :admin do
      admin     true
    end
  end
  
  factory :exercise do
    title              { FactoryGirl.generate(:title) }
    description        { FactoryGirl.generate(:description) }
    association(:user) { FactoryGirl.generate(:user) }
    body_part          "Back"
    equipment          { FactoryGirl.generate(:equipment) }
    cues               "Some cues up in this mo fo"
  end
  
  factory :workout do
    title              { FactoryGirl.generate(:title) }
    description        { FactoryGirl.generate(:description) }
    association(:user) { FactoryGirl.generate(:user) }
    exercises          { |exercises| [exercises.association(:exercise)] }
  end
  
  factory :booking do
    trainer            { |trainer| trainer.association(:user) }
    client             { |client| client.association(:client) }
    wo_date            { 3.days.from_now }    
    wo_time            { Time.now }
    message            { FactoryGirl.generate(:description) }
    association(:workout) { FactoryGirl.generate(:workout) }
  end
end