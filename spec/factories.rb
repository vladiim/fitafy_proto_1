require "authlogic/test_case"
include Authlogic::TestCase

Factory.define :user do |trainer|
   trainer.sequence(:username)  { |n| "test_user_#{n}"}
   trainer.sequence(:email)  { |n| "test_user_#{n}@email.com"}   
   trainer.password "password"
   trainer.password_confirmation "password"
   trainer.role "trainer_role"
end

Factory.define :workout do |workout|
  workout.sequence(:title) { |n| "#{n} Da heaps Hardcore Workout"}
  workout.sequence(:description) { |n| "#{n} Not for the feignt hearted" }
  workout.association(:user, factory: :user)
end

Factory.define :exercise do |exercise|
  exercise.sequence(:title) { |n| "#{n} Bench Press"}
  exercise.sequence(:description) { |n| "#{n} Do da bench press with your pectorials!!!" }
  exercise.association(:user, factory: :user)
  exercise.sequence(:body_part) { |n| "Back"}
  exercise.sequence(:equipment) { |n| "#{n} Equipment"}  
  exercise.sequence(:cues) { |n| "#{n} Cues"}  
end

Factory.define :booking do |booking|
  booking.trainer { |t| t.association(:user) }
  booking.client { |c| c.association(:user) }    
  booking.wo_date 3.days.from_now
  booking.association(:workout, factory: :workout)
  booking.sequence(:message) { |n| "#{n} message for the #{n}th time broooo" }
end