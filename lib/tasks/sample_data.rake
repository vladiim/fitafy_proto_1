namespace :db do
  desc "Fill dev database with data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_relationships
    make_exercises
    make_workouts    
    make_bookings    
  end
end

def make_users
  User.create!(username:                "nipolic",
               email:                   "trainer@email.com",
               password:                "password", 
               password_confirmation:   "password",
               role:                    "trainer_role"
  )
  User.create!(username:               "admin",
               email:                   "admin@email.com",
               password:                "password", 
               password_confirmation:   "password",
               role:                    "trainer_role",
               admin:                   true
  )
  20.times do |n|
    c_username = Faker::Name.first_name
    c_username = "#{c_username}_#{n}"
    c_email = "#{c_username}@email.com"
    password = "password"
    User.create!(username:                c_username,
                 email:                   c_email,
                 password:                password,
                 password_confirmation:   password,
                 role:                    "client_role"
    )
  end
end

def make_relationships
  @trainer = User.first
  users = User.all
  clients = users[5..15]
  clients.each { |client| @trainer.train!(client) }
end

def make_exercises
  @admin = User.find_by_username("admin")
  @admin.exercises.create!( title:          "Shoulder Press",
                    description:    "This exercise may be performed equally well standing or sitting. Raise the dumbbells to the shoulders. Hold the dumbbells such that the palms are facing forward (same hand position as when using a barbell).",
                    body_part:      "Shoulder",
                    equipment:      "Dumbbell",
                    cues:           "You may inhale or exhale as you raise the dumbbells, opposite while lowering the dumbbells - do not hold your breath. Take 2-3 seconds to raise, and 3-4 seconds to lower the dumbbells. Keep the knees slightly bent and pelvis slightly tucked.",
                    admin:          true
  )
  @admin.exercises.create!( title:          "Chin Up",
                    description:    "Begin from a hanging position on a fixed pull-up bar with your grip slightly wider than shoudler width.",
                    body_part:      "Back",
                    equipment:      "Chin up bar",
                    cues:           "Try using different grips to vary how you work your back and arms. Turn your palms away from you to work more forearm, and turn them toward you to work more biceps.",
                    admin:          true
  )
  @admin.exercises.create!( title:          "Dumbbell Bench Press ",
                    description:    "Grab two dumbbells, sit and then lie flat on a flat bench.",
                    body_part:      "Chest",
                    equipment:      "Dumbells Bench",
                    cues:           "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.",
                    admin:          true
  )
  @admin.exercises.create!( title:          "Squat",
                    description:    "Place the bar just behind the neck on the upper rear shoulders. Slowly sit down until the legs are parallel to the floor.",
                    body_part:      "Legs",
                    equipment:      "Barbell Squat-rack",
                    cues:           "Try not to let the knees bend over the front of the toes. Keep the lower back slightly arched.",
                    admin:          true
  )
  @admin.exercises.create!( title:          "Tricep cable pushdown",
                    description:    "Stand with your feet shoulder width apart with your knees slightly bent. Grab the bar and bring your elbows in close to your sides.",
                    body_part:      "Tricep",
                    equipment:      "Cable Machine",
                    cues:           "Keep your elbows stationary to isolate your triceps. Keep your body still to eliminate momentum, and keep your speed controlled.",
                    admin:          true
  )
  @admin.exercises.create!( title:          "Bicep Curl",
                    description:    "Begin from a standing position. Grasp the barbell with a shoulder-width grip, palms facing up. Hold the bar with the arms straight and the bar in front of the waist.",
                    body_part:      "Bicep",
                    equipment:      "Barbell",
                    cues:           "Exhale as you raise the bar, inhale as you lower the bar. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar.",
                    admin:          true
  )
end

def make_workouts
  @trainer = User.first  
  5.times do |n|
    @trainer.workouts.create(title: "#{n} workout", description: Faker::Lorem.sentence(3), exercise_ids: [1, 2, 3])
  end
end

def make_bookings
  @trainer = User.first
  n = 1
  @trainer.training.each do |client|
    workout = Workout.first
    @trainer.bookings.create(client_id: client.id, wo_date: n.days.from_now, wo_time: n.hours.from_now, workout_id: workout.id)
    n += 1
  end
end