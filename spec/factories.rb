require "authlogic/test_case"
include Authlogic::TestCase

Factory.define :user do |user|
   user.sequence(:username)  { |n| "test_user_#{n}"}
   user.sequence(:email)  { |n| "test_user_#{n}@email.com"}   
   user.password "password"
   user.password_confirmation "password"
end
