require "authlogic/test_case"
include Authlogic::TestCase

Factory.define :user do |trainer|
  trainer.sequence(:username)  { |n| "trainer_#{n}"}
  trainer.sequence(:email)  { |n| "trainer_#{n}@email.com"}   
  trainer.password "password"
  trainer.password_confirmation "password"
  trainer.role "trainer_role"
  trainer.admin false
  
  Factory.define :client do |client|
    client.role "client_role"
  end
  
  Factory.define :admin do |admin|
    admin.admin true
  end
end

Factory.define :exercise do |exercise|
  exercise.sequence(:title) { |n| "#{n} Bench Press"}
  exercise.sequence(:description) { |n| "#{n} Do da bench press with your pectorials!!!" }
  exercise.association(:user, factory: :user)
  exercise.sequence(:body_part) { |n| "Back"}
  exercise.sequence(:equipment) { |n| "#{n} Equipment"}  
  exercise.sequence(:cues) { |n| "#{n} Cues"}  
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

Factory.define :booking do |booking|
  booking.trainer { |t| t.association(:user) }
  booking.client { |c| c.association(:user) }    
  booking.wo_date 3.days.from_now
  booking.wo_time Time.now
  booking.sequence(:message) { |n| "#{n} message for the #{n}th time broooo" }
  booking.workout(factory: :workout)
end