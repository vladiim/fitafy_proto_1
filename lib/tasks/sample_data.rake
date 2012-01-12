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
  User.create!(:username => "Trainer",
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
  clients = users[1..30]
  clients.each do |client|
    trainer.bookings.create(:client => client, :wo_date => 1.week.from_now, :wo_time => Time.now)
  end
end