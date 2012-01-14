namespace :db do
  desc "Fill dev database with data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_relationships
    make_workouts
    make_bookings
  end
end

def make_users
  User.create!(:username => "nipolic",
               :email => "trainer@email.com",
               :password => "password", 
               :password_confirmation => "password"
  )
  50.times do |n|
    c_username = Faker::Name.first_name 
    c_email = Faker::Internet.email
    password = "password"
    User.create!(:username => c_username,
                 :email => c_email,
                 :password => password,
                 :password_confirmation => password
    )
  end
  
end

def make_relationships
  users = User.all
  trainer = users.first
  clients = users[1..50]
  clients.each { |client| trainer.train!(client) }
end

def make_workouts
  users = User.all
  trainer = users.first
  20.times.each do |n|
    trainer.workouts.create(:title => "#{n} workout", :description => Faker::Lorem.sentence(3))
  end
end

def make_bookings
  users = User.all
  trainer = users.first 
  clients = users[2..30]
  clients.each do |client, n|
    n = 1
    trainer.bookings.create(:client_id => client.id, :wo_date => n.days.from_now, :wo_time => n.hour.from_now)
    n += 1
  end
end