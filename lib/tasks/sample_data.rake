namespace :db do
  desc "Fill dev database with data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_relationships
  end
end

def make_users
  User.create!(:username => "Trainer",
               :email => "trainer@email.com",
               :password => "password", 
               :password_confirmation => "password"
  )
  50.times do |n|
    c_username = "Client #{n}"
    c_email = "client-#{n}@email.com"
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