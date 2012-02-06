require "authlogic/test_case"
include Authlogic::TestCase

Factory.define :user do |trainer|
  trainer.sequence(:username)  { |n| "trainer_#{n}"}
  trainer.sequence(:email)  { |n| "trainer_#{n}@email.com"}   
  trainer.password "password"
  trainer.password_confirmation "password"
  trainer.role "trainer_role"
  trainer.admin false
end

Factory.define :client, :class => User do |client|
  client.sequence(:username)  { |n| "client_#{n}"}
  client.sequence(:email)  { |n| "client_#{n}@email.com"}   
  client.password "password"
  client.password_confirmation "password"
  client.role "client_role"
  client.admin false
end

Factory.define :admin, :class => User do |admin|
  admin.sequence(:username)  { |n| "admin_#{n}"}
  admin.sequence(:email)  { |n| "admin_#{n}@email.com"}   
  admin.password "password"
  admin.password_confirmation "password"
  admin.role "trainer_role"
  admin.admin true
end

Factory.define :workout do |workout|
  workout.sequence(:title) { |n| "#{n} Da heaps Hardcore Workout"}
  workout.sequence(:description) { |n| "#{n} Not for the feignt hearted" }
  workout.association(:user, factory: :user)
  workout.exercises {
    count = 0
    Array(1..3).sample.times.map do
      Factory.create(:exercise, title: "Exercise #{count += 1}")
    end
  }
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
  booking.wo_time Time.now
  booking.sequence(:message) { |n| "#{n} message for the #{n}th time broooo" }
end