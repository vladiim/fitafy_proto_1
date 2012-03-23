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
  admin = User.create!(username:        "admin",
               email:                   "admin@email.com",
               password:                "password", 
               password_confirmation:   "password",
               role:                    "trainer_role"
  )
  # admin.toggle!(:admin)
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
  make_client_relationships(clients)
end

def make_client_relationships(clients)
  clients.each do |client|
    @trainer.train!(client)
    # relationship = @trainer.train!(client)
    # relationship.toggle(:accepted)
    # relationship.save
  end
end

def make_workouts
  @trainer = User.find(1)
  5.times do |n|
    @trainer.workouts.create(title: "#{n} workout", 
                             instructions: Faker::Lorem.sentence(5), 
                             exercise_ids: [1, 2, 3])
  end
end

def make_bookings
  @trainer = User.find(1)
  @workouts = [Workout.find(1), Workout.find(2), Workout.find(3), Workout.find(4)]
  
  @trainer.training.each do |client|
    n = 1
    @workouts.each do |workout|
      @trainer.bookings.create(client_id: client.id, 
                             wo_date: n.days.from_now, 
                             wo_time: n.hours.from_now, 
                             workout_id: workout.id,
                             status: "trainer_proposed",
                             last_message_from: @trainer.id)
      n += 1
    end
  end

  n = 2
  
  2.times do
    booking = Booking.find(n)
    booking.update_attributes(status: "client_proposed")
    n += 2
    booking2 = Booking.find(n)
    booking2.update_attributes(status: "revised_time")
    n += 2
    booking3 = Booking.find(n)
    booking3.update_attributes(status: "completed")
  end
end

def make_exercises
  @admin = User.find_by_username("admin")
  @admin.exercises.find_or_create_by_title(
  	 title: "Chin Up",
  	 body_part: "Back",
  	 equipment: "Pull Bar",
  	 description: "Begin from a hanging position on a fixed pull-up bar with your grip slightly wider than shoudler width.",
  	 cues: "Try using different grips to vary how you work your back and arms. Turn your palms away from you to work more forearm, and turn them toward you to work more biceps. Some facilities have an assisted pull-up machine. Try this if you're having difficulty reaching your goal number or repetitions.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Lat Pulldown",
  	 body_part: "Back",
  	 equipment: "Pulldown machine",
  	 description: "Adjust the knee pads/seat so your legs touch the knee pad. Grip the bar, wider than shoulder width. Sit upright and slightly lean back.",
  	 cues: "Adjust your upper body angle when you perform this exercise. Sitting upright will place more emphasis on your middle back (lats), while leaning back will place more emphasis on the muscles near your spine (rhomboids).")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Seated Row",
  	 body_part: "Back",
  	 equipment: "Low cable row",
  	 description: "Sit upright with your legs slightly bent and your feet together. Grasp handle and pull elbows towards to your sides, keeping your hands level with your lower rib cage. Squeeze your shoulder blades together near the end of the pull. Hold for 1/2 second, and then slowly return to the starting position.",
  	 cues: "Keep your torso upright. Focus on keeping your chest out and lower back muscles tight.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Seated Row (Elastic band)",
  	 body_part: "Back",
  	 equipment: "Elastic band",
  	 description: "Sit upright with your legs slightly bent and your feet together. Hold one end of the band in each hand, and place the center of the band across the bottoms of your feet. Adjust the tension of the band by grabbing higher or lower on it or by wrapping it around your hands.",
  	 cues: "Keep your torso upright. Focus on keeping your chest out and lower back muscles tight.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Seated Row (Wide bar grip)",
  	 body_part: "Back",
  	 equipment: "low cable row, Wide bar",
  	 description: "Place your feet on the supports with your knees slightly flexed. Grab the bar with a wide grip (As wide as your elbows when you extend them out to the sides). Sit upright with your torso vertical, keeping the natural arch in your lower spine.",
  	 cues: "A wonderful exercise for improving your posture. It helps strengthen the muscles that roll your shoulders back.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Prone Row",
  	 body_part: "Back",
  	 equipment: "Dumbbells",
  	 description: "Lay face down on a stable flat bench. While maintaining good posture i.e. Head face down and back straight, grasp two dumbbells (from floor) and pull vertically in to your sides.",
  	 cues: "A wonderful exercise for improving your posture. It helps strengthen the muscles that roll your shoulders back. Feel your upper back muscles initiate the entire movement.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Prone Row",
  	 body_part: "Back",
  	 equipment: "barbell",
  	 description: "Lay face down on a stable flat bench. While maintaining good posture i.e. Head face down and back straight, grasp barbell (from floor) and pull vertically so your elbows reach your sides.",
  	 cues: "A wonderful exercise for improving your posture. It helps strengthen the muscles that roll your shoulders back. Feel your upper back muscles initiate the entire movement.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Bent Over Row",
  	 body_part: "Back",
  	 equipment: "barbell",
  	 description: "Stand over the barbell with the legs slightly bent and back flat. Bend down and grasp the barbell about shoulder width. Pull the bar to the lower chest. Keep the back approximately parallel to the floor, try not to rest the bar on the floor between repetition.",
  	 cues: "Be careful with this exercise if you have lower back problems, start light and progress slowly. If problems persist substitute for another exercise such as a machine based seated row.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Bent Over Row (dumbbells)",
  	 body_part: "Back",
  	 equipment: "Dumbbells",
  	 description: "Hold the dumbbells in front of you with your palms facing the back. Bend over at the waist. Keep your knees slightly bent and your back flat.",
  	 cues: "Exhale as you pull the dumbbells up, inhale as you lower the dumbbells towards the floor. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Close grip Pulldown",
  	 body_part: "Back",
  	 equipment: "Lat pulldown machine",
  	 description: "Adjust the knee pads/seat so your legs touch the knee pad. Use the handle which resembles a traingular prism or arternatively use a reverse grip on a long bar. Sit upright and slightly lean back.",
  	 cues: "Adjust your upper body angle when you perform this exercise. Sitting upright will place more emphasis on your middle back (lats), while leaning back will place more emphasis on the muscles near your spine (rhomboids).")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Deadlift",
  	 body_part: "Back",
  	 equipment: "barbell",
  	 description: "Stand as close to the bar as possible, feet shoulder width apart. Grip the bar with one palm facing down and one palm facing up (mixed grip), slightly wider than shoulder width apart. Keep your spine as straight as possible, bending at the hips. You should have a moderate bend in the knees.",
  	 cues: "One of the best exercises to develop strength in your lower back, thighs, and butt in one movement. It's a functional exercise, which strengthens your muscles for lifting activities and helps to prevent lower back injury.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Deadlift",
  	 body_part: "Back",
  	 equipment: "Dumbbells",
  	 description: "Stand as close to the bar as possible, feet shoulder width apart. Hold a dumbbell in each hand in front of your hips. Keep your spine as straight as possible and gently bend at the hips. You should have a moderate bend in the knees.",
  	 cues: "One of the best exercises to develop strength in your lower back, thighs, and butt in one movement. It's a functional exercise, which strengthens your muscles for lifting activities and helps to prevent lower back injury.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Pull Over",
  	 body_part: "Back",
  	 equipment: "Dumbbells",
  	 description: "Lying on a bench, grasp one end of the dumbbell with both hands. Place your palms so they face the inside end-plate of the dumbbell, with your fingers and thumbs touching. Press it above your shoulders, leaving a slight bend in the elbows.",
  	 cues: "Inhale deeply as you lower the dumbbell, and exhale as you lift it back to your starting position. Go slowly, taking 3-4 seconds to lower and raise the dumbbell.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Good Morning",
  	 body_part: "Back",
  	 equipment: "barbell",
  	 description: "Place a barbell on the base fo your neck, comfortably on the upper back (trapezius) muscle. Stand with feet shoulder width apart.",
  	 cues: "Bend at the hips, not at the lower spine. Keep your back flat throughout the whole movement.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "One arm row",
  	 body_part: "Back",
  	 equipment: "Dumbbells",
  	 description: "Hold a dumbbell in one hand and place the opposite side knee and hand on a padded bench.",
  	 cues: "Exhale as you pull the dumbbell to the chest, inhale as you lower the dumbbell towards the floor. Take 2-3 seconds to raise the dumbbell, 3-4 seconds to lower the dumbbell.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Back Extension",
  	 body_part: "Back",
  	 equipment: "Swiss ball",
  	 description: "Lay over the ball and find your balance point. Place your feet wider than shoulder width. Extend your arms straight at a 45 degree angle from your head, thumbs facing the ceiling.",
  	 cues: "Make sure your head is in proper spinal alignment (like you were standing up straight). Avoid overextending the lower spine. Only do as many reps as perfect form allows!")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Back Extension",
  	 body_part: "Back",
  	 equipment: "roman chair",
  	 description: "Get into a back extension bench and check the height of the pad. Adjust the pad height so that the top of the pad is just below your front hip bones. Hold a dumbbell or weight plate across your chest with both hands to increase intensity.",
  	 cues: "Lower your torso as far you comfortably can, focusing on rounding your spine. Contract your lower back, buttocks and thigh muscles simuultaneously to lift your torso until your upper body is aligned with your lower body. Hold for 1 second at the top, then repeat.")
  

  @admin.exercises.find_or_create_by_title(
  	 title: "Superman",
  	 body_part: "Back",
  	 equipment: "",
  	 description: "Lie on your stomach, and bring your arms up by your ears.",
  	 cues: "Feel your gluteal (butt) and lower back muscles contract, and hold that position. Keep your neck in line with your spine throughout the exercise.")
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Barbell Bench Press",
  	 body_part: "Chest",
  	 equipment: "Barbell",
  	 description: "Lie flat on the bench with the feet firmly pressing into the floor. Place your grip on the bar slightly wider than shoulder width. Remove the bar from the supports.",
  	 cues: "Use a wider grip with the elbows perpendicular to the torso to focus on the chest; use a narrow grip with elbows in close to focus on the triceps.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Dumbbell Bench Press",
  	 body_part: "Chest",
  	 equipment: "Dumbbell",
  	 description: "Grab two dumbbells, sit and then lie flat on a flat bench.",
  	 cues: "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Dumbbell Flyes",
  	 body_part: "Chest",
  	 equipment: "Dumbbell",
  	 description: "Grab two dumbbells, sit and then lie on a flat bench, holding the dumbbells just above the chest. Start by pressing the weight above you. As you extend the arms turn your palms toward one another.",
  	 cues: "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Incline Dumbbell Press",
  	 body_part: "Chest",
  	 equipment: "",
  	 description: "Set yor incline bench to a 45 degree angle. Lie on your back on the incline bench and position the dumbbells beside your upper chest.",
  	 cues: "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Incline Dumbbell Flyes",
  	 body_part: "Chest",
  	 equipment: "Dumbbell",
  	 description: "Grab two dumbbells, sit and then lie on an incline bench set a a 45 degree angle. Holding dumbbells just above the chest. Start by pressing the weight above you. As you extend the arms turn your palms toward one another.",
  	 cues: "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Decline Dumbbell Press",
  	 body_part: "Chest",
  	 equipment: "Dumbbell",
  	 description: "Set yor adjustable bench to 20 to 30 degree angle below the line of a flat bench.  Lie on your back on the decline bench and position the dumbbells beside your lower chest.",
  	 cues: "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Decline Dumbbell Flyes",
  	 body_part: "Chest",
  	 equipment: "Dumbbell",
  	 description: "Grab two dumbbells, sit and then lie on an decline bench set at 20-30 degree angle below the line of a flat bench. Holding dumbbells just above the chest.",
  	 cues: "Exhale as you press the dumbbells off chest, inhale as the dumbbells are lowered. Take 2-3 seconds to raise the dumbbells, and 3-4 seconds to lower the dumbbells.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Close Grip Bench Press",
  	 body_part: "Chest",
  	 equipment: "Barbell",
  	 description: "Lie flat on the bench with the feet firmly pressing into the floor. Place your grip on the bar slightly narrower than shoulder width. Remove the bar from the supports.",
  	 cues: "Don't expect to use as much weight as with regular bench press since you won't have as much chest involvement. Also, let the wrists adapt gradually to the added strain of the close grip.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Push Up",
  	 body_part: "Chest",
  	 equipment: "",
  	 description: "Keeping the body in a straight line, slowly lower yourself until the chest is close to touching the floor. Hold for one second, then press yourself upwards. While doing the push-up, the hands should be directly under the shoulders. Keep the stomach tight to help keep the body straight and prevent lower back pain.",
  	 cues: "Inhale as you lower the body, exhale as you press up. Important - if you let the hips sag you will stress your lower back. Keep the stomach tight and back straight. Don't let your head hang down, keep your neck in line with your spine. This exercise can also be modified to the knees to create less resistance.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Push Up Intermediate",
  	 body_part: "Chest",
  	 equipment: "Bench, Chair",
  	 description: "Place the back of a chair/bench against a wall to keep it from sliding. Place your hands on the edge of the seat or on the arm rests. Kneel on the ground, and move your knees away from the chair until your upper and lower body are aligned.",
  	 cues: "Don't let your hips sag. This places additional stress on the lower back. Keep your abdominals tight. This will help you maintain proper form.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Push Up               (Beginner)",
  	 body_part: "Chest",
  	 equipment: "Wall",
  	 description: "Stand a few feet away from a wall or countertop, and place your hands shoulder-width apart on it. Slowly lower yourself down until your chest is close the wall/counter, keeping your body in a straight line throughout the movement. Hold for 1/2 second, and then return to the starting position.",
  	 cues: "Try this simpler version of the traditional Push-up if regular and/or Modified Push-ups are difficult for you.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Cable Cross Over",
  	 body_part: "Chest",
  	 equipment: "Dual Cable Machine",
  	 description: "Grasp the handles with the palms facing inward. Stand in the middle of the cable machine with one foot slightly in front of one another. Slightly bend forward at the hips, keeping your back in its naturally arched position. Extend your slightly bent arms back and outward until your feel a stretch in your chest.",
  	 cues: "This is a traditional exercise used by bodybuilders to focus on their inner chest development. Focus on good form, with slow and controlled movements. Point of contraction can change depending the angle of handle movement i.e. Upper pecs can be targeted with a cross over starting from the bottom setting on the machine to a contraction which finishes at shoulder height.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Swiss Dumbbell Press",
  	 body_part: "Chest",
  	 equipment: "Swiss ball, Dumbbells",
  	 description: "Sit on a Swiss ball with the dumbbells on your thighs, feet approximately shoulder width apart. Roll down the ball until your mid and upper back are supported. Bring the weights up to shoulder level in a chest press position.",
  	 cues: "Narrow your foot width to decrease stability and further challenge your torso muscles. Try to keep your body as still and stable as possible throughout the exercise.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Swiss Ball                  Push Up",
  	 body_part: "Chest",
  	 equipment: "Swiss ball, Dumbbells",
  	 description: "Get in a push-up position with your toes on the ball. Place your hands shoulder width apart. Align your shoulders directly over your hands.",
  	 cues: "Focus on keeping your torso very tight and stable. To make the exercise easier, place your shins on the ball. To increase difficulty, place toes on the ball or even have only one foot in contact with the swiss ball.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Chest Press with Elastic Band",
  	 body_part: "Chest",
  	 equipment: "Elastic Band",
  	 description: "Sit upright in a chair or on the ground. Hold one end of the band in each hand, and place it around your upper back.",
  	 cues: "You don't have to sit on the floor to do this exercise. If the band is long enough, you may wrap it around the back of a chair.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Chest Press",
  	 body_part: "Chest",
  	 equipment: "Chest Press Machine",
  	 description: "Adjust the seat so that your hands are level with the middle of your chest when you grasp the handles. Inhale and lift your chest high.",
  	 cues: "For variety, try doing the movements iso-laterally. First, extend your left arm, and then bring it back in as you extend your right arm. Continue to alternate.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Close Grip Bench Press",
  	 body_part: "Chest",
  	 equipment: "Barbell",
  	 description: "Lie flat on the bench with the feet firmly pressing into the floor. Place your grip on the bar slightly narrower than shoulder width. Remove the bar from the supports.",
  	 cues: "Don't expect to use as much weight as with regular bench press since you won't have as much chest involvement. Also, let the wrists adapt gradually to the added strain of the close grip.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Parallel Bar Dips",
  	 body_part: "Tricep",
  	 equipment: "Parallel Bars",
  	 description: "Stand securely on elevated step of parallel bar aparatus (if available). Start with arms extended holding entire body weight.Legs can straight or crossed depending on height of individual and aparatus.",
  	 cues: "Maintain good posture with chest out and shoulders blades back. Keep elbows soft (not locking out) throught the entire movement and set.")
 
  @admin.exercises.find_or_create_by_title(
  	 title: "Squat",
  	 body_part: "Legs",
  	 equipment: "barbell",
  	 description: "Place the bar just behind the neck on the upper rear shoulders. Slowly sit down until the legs are parallel to the floor. Lift the chest up and press the legs into the floor as you press back to a standing position.",
  	 cues: "Try not to let the knees bend over the front of the toes. Keep the lower back slightly arched.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Wall Squat",
  	 body_part: "Legs",
  	 equipment: "n/a",
  	 description: "Lean your back against a wall, and stand 1-2 feet away from it with your feet shoulder-width apart.",
  	 cues: "Try not to let the knees bend over the front of the toes. Keep the lower back slightly arched.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Wall Squat",
  	 body_part: "Legs",
  	 equipment: "Swiss Ball",
  	 description: "Place the swiss ball in the lumbar region of the back. Lean your back against a wall, and stand 1-2 feet away from it with your feet shoulder-width apart.",
  	 cues: "Try not to let the knees bend over the front of the toes. Keep the lower back slightly arched.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Front Squat",
  	 body_part: "Legs",
  	 equipment: "barbell",
  	 description: "Take the bar from the support stands or power rack, or from the floor bring the bar up to the shoulders. Bend the wrists and bring the elbows up as much as possible. The bar should rest on the front of the shoulders.",
  	 cues: "Inhale deeply as you squat down, exhale as you begin to squat up.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Squat to bench/chair",
  	 body_part: "Legs",
  	 equipment: "",
  	 description: "Stand with your feet shoulder width apart with a chair directly behind you.",
  	 cues: "Keep your knees aligned over your toes. Keep your heels on the ground at all times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Pistol Squat",
  	 body_part: "Legs",
  	 equipment: "n/a",
  	 description: "From a standing position, place one foot in front of you on an ankle-height box or bench. Slowly squat down on one leg until the knee is bent approximately 90 degrees.",
  	 cues: "Inhale deeply as you squat down, exhale as you begin to squat up.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Overhead Squat",
  	 body_part: "Legs",
  	 equipment: "barbell",
  	 description: "Take the bar from a power rack, support stands or the floor using a wide grip. Press the bar overhead.",
  	 cues: "Keep your knees aligned over your toes. Keep your heels on the ground at all times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Lunge",
  	 body_part: "Legs",
  	 equipment: "dumbells, Barbell optional",
  	 description: "Stand with your feet about hip width apart. Take a comfortable long step forward and keep torso upright with a straight back.",
  	 cues: "The knee of your front leg should be directly over your ankle.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Walking Lunge",
  	 body_part: "Legs",
  	 equipment: "Dumbbells",
  	 description: "Hold the dumbbells at your sides, keeping an upright posture. Stand with your feet about hip width apart.",
  	 cues: "The knee of your front leg should be directly over your ankle.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Back Lunge",
  	 body_part: "Legs",
  	 equipment: "",
  	 description: "Hold a dumbbell in each hand with your arms extended straight down at your sides.",
  	 cues: "Do not let your front knee bend more than 90 degrees or over the front of your toes.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Dynamic Lunge",
  	 body_part: "Legs",
  	 equipment: "",
  	 description: "Hold a dumbbell in each hand with your arms extended straight down at your sides.",
  	 cues: "Do not let your front knee bend more than 90 degrees or over the front of your toes.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Side Lunge",
  	 body_part: "Legs",
  	 equipment: "Dumbbells Optional",
  	 description: "Stand upright with your feet close together.",
  	 cues: "Keep the kneecap of your lunging leg in line with your foot during the movement.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Step Up",
  	 body_part: "Legs",
  	 equipment: "Dumbbells Optional",
  	 description: "Step up and down with one leg, keeping the same leg on the platform throughout the set. Step onto the platform (bench, chair, or step) with one leg, focusing on pulling your bodyweight up with that leg only. Slowly lower your body until your trailing leg lightly touches the ground. Keep your top foot on the platform, and repeat for the desired number of repetitions.",
  	 cues: "Begin with a low step (about 30cm high), and progress to a higher bench/chair as you become comfortable with the exercise. Keep the movement slow and controlled, especially on the way down.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Deadlift",
  	 body_part: "Legs",
  	 equipment: "barbell",
  	 description: "Stand as close to the bar as possible, feet shoulder width apart. Grip the bar with one palm facing down and one palm facing up (mixed grip), slightly wider than shoulder width apart. Keep your spine as straight as possible, bending at the hips. You should have a moderate bend in the knees.",
  	 cues: "One of the best exercises to develop strength in your lower back, thighs, and butt in one movement. It's a functional exercise, which strengthens your muscles for lifting activities and helps to prevent lower back injury.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Leg Extension",
  	 body_part: "Legs",
  	 equipment: "Leg Extension machine",
  	 description: "Adjust the seat (if necessary) so that your back is against the pad and your knees can extend freely through a full range of motion. Place your feet behind the rollers.",
  	 cues: "Exhale as you extend your legs, and inhale as you lower the weight.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Leg Curl",
  	 body_part: "Legs",
  	 equipment: "Leg curl machine",
  	 description: "Lie on the bench, and adjust your body position so the pads are just above your heels.",
  	 cues: "To prevent lower back strain, avoid raising your hips off the pad as you curl the weight.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Swiss ball Leg Curl",
  	 body_part: "Legs",
  	 equipment: "Swiss Ball",
  	 description: "Ajust the rear pad of the seat so the back of knee joint hangs over the edge while your back is flat on the pad. Adjust the pad so it rests just above your heels.",
  	 cues: "Keep your movement smooth and controlled.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Russian Leg Curl",
  	 body_part: "Legs",
  	 equipment: "",
  	 description: "",
  	 cues: "")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "45 degree           Leg Press",
  	 body_part: "Legs",
  	 equipment: "45 degree Leg Press machine",
  	 description: "Adjust the seat so that your knees are bent 90 degrees when your back is flat against the rear seat pad. Place your feet on the platforms with your toes pointed straight ahead.",
  	 cues: "Keep your lower back flat aginst the cushions. Keep your knees aligned over the center of your toes and maintain contact of your heels on the platforms at all times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Hack Squat",
  	 body_part: "Legs",
  	 equipment: "Hack Squat machine",
  	 description: "Place the shoulders underneath the shoulder pads and grasp the hands on the handles of the carriage while placing the feet hip width apart or slightly closer with the feet pointed forward. Keep the back flat against the back pad at all times. Use either hand to release the lever arm outward to allow the machine to disengage for movement to begin.",
  	 cues: "Try to keep the back upright throughout the entire movement.")
   
  @admin.exercises.find_or_create_by_title(
  	 title: "Shoulder Press",
  	 body_part: "Shoulders",
  	 equipment: "dumbbell",
  	 description: "This exercise may be performed equally well standing or sitting. Raise the dumbbells to the shoulders. Hold the dumbbells such that the palms are facing forward (same hand position as when using a barbell).",
  	 cues: "You may inhale or exhale as you raise the dumbbells, opposite while lowering the dumbbells - do not hold your breath. Take 2-3 seconds to raise, and 3-4 seconds to lower the dumbbells. Keep the knees slightly bent and pelvis slightly tucked.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Shoulder Press",
  	 body_part: "Shoulders",
  	 equipment: "barbell",
  	 description: "This exercise may be performed equally well standing or sitting. Stand straight and raise the barbell from the floor or supports and place in front of the neck, just above the chest .",
  	 cues: "You may inhale or exhale as you raise the bar, opposite while lowering the bar - do not hold your breath. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Shoulder Press",
  	 body_part: "Shoulders",
  	 equipment: "dumbell, swissball",
  	 description: "Sit upright on a Swiss Ball, with your chest lifted and your head level. Place your feet approximately shoulder width apart. Begin by holding the dumbbells at ear level, with your palms facing forward.",
  	 cues: "Develop strong shoulders, learn to stabilize your torso, and improve your balance with this Swiss Ball variation of the Shoulder Press. Narrow your foot width to further challenge your torso stability, and widen it to add ease.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Shoulder Press",
  	 body_part: "Shoulders",
  	 equipment: "elastic band",
  	 description: "Sit upright on a Swiss Ball, with your chest lifted and your head level. Place your feet approximately shoulder width apart. Begin by holding the dumbbells at ear level, with your palms facing forward.",
  	 cues: "Develop strong shoulders, learn to stabilize your torso, and improve your balance with this Swiss Ball variation of the Shoulder Press. Narrow your foot width to further challenge your torso stability, and widen it to add ease.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Upright Row",
  	 body_part: "Shoulders",
  	 equipment: "barbell",
  	 description: "From a standing position, grasp a barbell and raise to waist level.",
  	 cues: "Try a wider grip to shift focus on the shoulders, a narrow grip to focus more on the neck.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Side Raise",
  	 body_part: "Shoulders",
  	 equipment: "dumbbell",
  	 description: "From either a standing or seated position, begin with the dumbbells at the sides and palms facing inward towards the waist.",
  	 cues: "Keep the elbows slightly bent to relieve elbow strain. Maintain good posture throughout the exercise.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Side Raise",
  	 body_part: "Shoulders",
  	 equipment: "cable cross over machine",
  	 description: "Attach a handle to the low cable pulley. Stand to the side of the pulley, with the handle on the left side. Grab the handle with the right hand and step 1-2 feet away. Stand tall, holding the handle in front of the hips with a slightly bent elbow.",
  	 cues: "Keep the elbows slightly bent to relieve elbow strain. Maintain good posture throughout the exercise.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Front Raise",
  	 body_part: "Shoulders",
  	 equipment: "dumbbell",
  	 description: "From a standing position, grab the dumbbells and hold in front of the body at waist height with the palms facing towards the body.",
  	 cues: "Remember this is an isolating exercise, don't expect to use a lot of weight. Do not swing the dumbbells quickly up")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Front Raise",
  	 body_part: "Shoulders",
  	 equipment: "elastic band",
  	 description: "From a standing position, Place the band under one or both feet. Stand upright and hold the ends of the band in each hand.",
  	 cues: "Remember this is an isolating exercise. Slowly raise both arm straight out in front of you. Hold for 1/2 second, then slowly return.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "External Rotation",
  	 body_part: "Shoulders",
  	 equipment: "dumbbell",
  	 description: "Raise the dumbbell to the side as if doing a side raise. Stop when the upper arm is shoulder level, then bend the elbow 90 degrees such that the dumbbell is in front of the elbow.",
  	 cues: "The rotator cuff is comprised of small muscles, don't expect to use heavy weights.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "External Rotation             (Lying on side)",
  	 body_part: "Shoulders",
  	 equipment: "dumbbell",
  	 description: "Lie on your side with a dumbbell in your top hand, bend your arm at a 90 degree angle with your elbow pressed at the side of your body. Lower the dumbbell towards the floor.",
  	 cues: "The rotator cuff is comprised of small muscles, don't expect to use heavy weights.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "External Rotation",
  	 body_part: "Shoulders",
  	 equipment: "elastic band",
  	 description: "Tie one end of the elastic band onto a fixed object.",
  	 cues: "The rotator cuff is comprised of small muscles, don't expect to use heavy weights.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Rear Shoulder Flyes",
  	 body_part: "Shoulders",
  	 equipment: "dumbells, flyes",
  	 description: "Grab the dumbbells and Slowly bend forward at the waist until the upper body is nearly parallel to the floor. Allow the dumbbells to swing forward until directly beneath the shoulders.",
  	 cues: "Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar. Avoid over-arching the lower back")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Push Press",
  	 body_part: "Shoulders",
  	 equipment: "Barbell or Dumbbell",
  	 description: "Stand with your feet shoulder width apart. Raise the dumbbells or Barbell to your shoulders.",
  	 cues: "Powerfully exhale as you press the dumbbellsl overhead.")

  @admin.exercises.find_or_create_by_title(
  	 title: "Bicep Curl",
  	 body_part: "Biceps",
  	 equipment: "barbell",
  	 description: "Begin from a standing position. Grasp the barbell with a shoulder-width grip, palms facing up. Hold the bar with the arms straight and the bar in front of the waist.",
  	 cues: "Exhale as you raise the bar, inhale as you lower the bar. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Bicep Curl",
  	 body_part: "Biceps",
  	 equipment: "Cable machine",
  	 description: "Grab the cable curl bar (straight or curved) and stand shoulder width, knees slightly flexed and abdominals tight. With your arms straight and tucked in close to your sides, align your elbows with the front of your abdomen.",
  	 cues: "Keep those elbows still to isolate your biceps. Keep your body still to eliminate any momentum, and keep your speed controlled. Let the biceps do the work!")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Bicep Curl",
  	 body_part: "Biceps",
  	 equipment: "Dumbbell",
  	 description: "Stand in an upright position, feet hip-width apart and shoulders back. Place your straight arms close to your sides, palms facing the front. Align your elbows with the front of your abdomen.",
  	 cues: "Keep your elbows close to your sides, and don't allow them to move away during the movement. Keep your body still, holding your abdominals tight. This reduces any momentum, forcing the biceps to do all the work.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Concentration Curl",
  	 body_part: "Biceps",
  	 equipment: "Dumbbell",
  	 description: "Sit on the edge of a bench, dumbbell in hand. Lean forward and place your elbow on the inside of the thigh, close to your knee.",
  	 cues: "Keep your elbow against your thigh and avoid excessive body movement. Try to make the biceps do all the work.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Inlcine curl",
  	 body_part: "Biceps",
  	 equipment: "Dumbbell",
  	 description: "Lie back on an incline bench (45 degrees). Let your arms hang down at your sides, with the dumbbells in your hands, and your palms facing each other.",
  	 cues: "Keep your elbows close to your sides, and don't allow them to swing or shift position during the exercise.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Preacher Curl",
  	 body_part: "Biceps",
  	 equipment: "Dumbbell",
  	 description: "Rest your arms comfortably on the preacher bench pad. Holding one dumbbell, extend the arm as much as comfortably possible.",
  	 cues: "Exhale as you raise the dumbbell, and inhale as you lower it. Take 2-3 seconds to raise the dumbbell and 3-4 seconds to lower it.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "EZ bar Bicep Curl",
  	 body_part: "Biceps",
  	 equipment: "EZ bar",
  	 description: "Grasp the EZ-Bar with a shoulder-width grip.",
  	 cues: "Exhale as you raise the bar, inhale as you lower the bar. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "EZ Bar Preacher Curl",
  	 body_part: "Biceps",
  	 equipment: "EZ bar, Preacher bench",
  	 description: "Rest your arms comfortably on the preacher bench pad.",
  	 cues: "Exhale as you raise the bar, and inhale as you lower the bar. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "EZ Bar Reverse Curl",
  	 body_part: "Biceps",
  	 equipment: "EZ bar",
  	 description: "Grasp the bar with either a narrow or shoulder-width grip (whichever feels most comfortable). The grip position on the EZ-Bar should be situated so that your palms are facing toward each other as opposed to away from each other.",
  	 cues: "Exhale as you raise the bar, inhale as you lower the bar. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar. Attempt to keep your elbows close to your sides, and avoid swaying the body.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Reverse Preacher curl",
  	 body_part: "Biceps",
  	 equipment: "barbell",
  	 description: "Rest your arms comfortably on the preacher bench pad. Grasp the barbell with a 6-12 inch wide grip.",
  	 cues: "Exhale as you raise the bar, inhale as you lower the bar. Take 2-3 seconds to raise the bar and 3-4 seconds to lower the bar.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "curl on Swiss Ball",
  	 body_part: "Biceps",
  	 equipment: "Dumbbell",
  	 description: "Sit on a Swiss ball with your back straight, your chest up and your head level. Place your arms at your sides holding the dumbbells in your hands.",
  	 cues: "Keep your elbows stationary throughout the exercise.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Hammer Curl",
  	 body_part: "Biceps",
  	 equipment: "Dumbbell",
  	 description: "Stand in an upright position, feet hip-width apart and shoulders back. Place your straight arms close to your sides, palms facing each other and end of dumbbell pointed to ground (hammer). Align your elbows with the front of your abdomen.",
  	 cues: "Keep your elbows close to your sides, and don't allow them to move away during the movement. Keep your body still, holding your abdominals tight. This reduces any momentum, forcing the biceps to do all the work.")

  @admin.exercises.find_or_create_by_title(
  	 title: "Tricep Cable Pushdown",
  	 body_part: "Tricep",
  	 equipment: "Cable machine",
  	 description: "Stand with your feet shoulder width apart with your knees slightly bent. Grab the bar and bring your elbows in close to your sides. Align your elbows with the front of your abdomen.",
  	 cues: "Keep your elbows stationary to isolate your triceps. Keep your body still to eliminate momentum, and keep your speed controlled.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "One Arm Kickback",
  	 body_part: "Tricep",
  	 equipment: "dumbbell",
  	 description: "Place one knee and hand on a bench for support. Bend over at the hips so your back is approximately parallel to the floor. With a dumbbell in the other hand, raise the upper arm so it too is parallel to the ground. Let your lower arm hang vertical.",
  	 cues: "As you bend over to support with one arm, keep your hips and shoulders aligned so your spine stays in it's natual aligned position. Keep your upper arm horizontal and only return your arm to the vertical position to further isolate the triceps. Lower and raise the dumbbell slowly to avoid letting momentum do the work.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Above head arm extension",
  	 body_part: "Tricep",
  	 equipment: "dumbbell",
  	 description: "Seated on a bench, grasp one end of the dumbbell with both hands (palms up) and raise it overhead. Position your palms so they face the inside end-plate of the dumbbell. Keep your fingers and thumbs touching.",
  	 cues: "Keep your elbows stationary and close to your head. Do not let them flare out.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Above head One arm extension",
  	 body_part: "Tricep",
  	 equipment: "dumbbell",
  	 description: "With a dumbbell in your right hand, raise your right arm directly overhead. Keep your body upright and your abdominals tight to support your spine",
  	 cues: "Keep your elbow stationary throughout the movement to effectively isolate your triceps.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Above head One arm extension",
  	 body_part: "Tricep",
  	 equipment: "elastic band",
  	 description: "Hold the dyna band in your right hand, and raise your right arm directly overhead. Let your right elbow bend so your wrist is behind your neck. Reach behind you with your left hand, and grab the dangling band.",
  	 cues: "You can easily adjust the resistance by changing your grip width on the band. Experiment until you find your optimal level of resistance.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "EZ Bar Arm Extension               (lying Supine)",
  	 body_part: "Tricep",
  	 equipment: "EZY Bar",
  	 description: "Lying on a flat bench, raise the bar over the chest. Keep the elbows in place and lower the bar behind the forehead to neck level. Raise the bar back to the starting position, keeping your elbows stationary throughout.",
  	 cues: "Do not lower the bar toward your face, and be careful not to hit your head with the barbell. Move the elbows if necessary to allow the bar to drop below the head.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Close grip      Push-up",
  	 body_part: "Tricep",
  	 equipment: "n/a",
  	 description: "Kneel down and place your hands a few inches apart on the mat. Form a spade with your hands by pointing your index fingers inward. Extend your legs out straight and balance on your toes.",
  	 cues: "Prevent your hips from sagging by keeping your abdominals tight. Never lock out your elbows.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Bench Dip",
  	 body_part: "Tricep",
  	 equipment: "Bench, chair",
  	 description: "Sit down on bench with hands placed hip width. Secure hands so all pressure is taken through the butt of the palm to minimise stress on wrist joint.",
  	 cues: "Maintain good posture with chest out and shoulders blades back. Keep elbows soft (not locking out) throught the entire movement and set.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Parallel Bar Dips",
  	 body_part: "Tricep",
  	 equipment: "parallel bars",
  	 description: "Stand securely on elevated step of parallel bar aparatus (if available). Start with arms extended holding entire body weight.Legs can straight or crossed depending on height of individual and aparatus.",
  	 cues: "Maintain good posture with chest out and shoulders blades back. Keep elbows soft (not locking out) throught the entire movement and set.")

  @admin.exercises.find_or_create_by_title(
  	 title: "Sit Up",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Begin on the ground in a supine (face up) position with your knees positioned at 90 degrees. Palce your hands behind your head with your elbows pointing outwards. Slowly contract your abdominals to raise shoulder blades off the ground, pause for 1 second and then return to start position.",
  	 cues: "Increase the intensity of this exercise, you may start with the hands on the knees and then progress to arms crossed over the shoulders. Perform 2 or 3 sets of 15-20 reps.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Swiss ball Abdominal Crunch",
  	 body_part: "Abdominals",
  	 equipment: "swiss ball",
  	 description: "Commence seated on the ball with your feet shoulder width apart. Slowly roll down until your lumbar spine is comfortably curving with the contour of the ball. Engage the lower abdominal to stabilise your hips and the roll your upper torso up the ball until a contraction is felt in the rectus abdominus (front of abs). Slowly return to start position.",
  	 cues: "The following order of arm location will increase the intesnity of this exercise; hands on thighs, Arms crossed over chest, Hand behind the head and finally holding a weight either on the chest or behind the head (advanced). 3 sets of 20 reps.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Reverse crunch",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Lie down on the floor face up with your hands down by your sides. With your legs bent at 90 degrees bring your knees up towards your chest slightly raising your hips up off the ground. Pause for a moment and the return to start position.",
  	 cues: "Perform in slow and controlled manner and avoid momentum to complete the exercise. Keep your legs straight to increase the difficulty of the exercise. Perform 10-20 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Bicycle Sit up",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Start on the floor with your legs bent at 90 degrees, heels off the ground and your hands behind your head. Contract the abdominals to raise both shoulder blades off the ground and then move the left elbow and towards the right knee while extending  the left leg out straight to 45 degrees. Complete this movement on the other side and then continue to alternate without pause.",
  	 cues: "A contraction of the abdominals is required during this entire movement. The exercise can be done for time e.g. 30-60 secs or repetitions e.g. 30-40 reps.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Side Plank",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Commence lying down on one side with your feet scissored for stability. Take your bodyweight on to your elbow and forearm and then raise the hips to form a straight aligminent  in the body. The only points of contact with the ground should be the arm and side of the feet.",
  	 cues: "Maintain your elbow directly under your shoulder and leave your free arm for support or safety.You may place it on your hip once comfortable. Engaging the abdominals will prevent your hips from sagging. Start with a 15 second hold and progress to 60 seconds as you are able. Repeat 2-3 times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Side Plank (knee on ground)",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Commence lying down on one side with your feet scissored for stability. Take your bodyweight on to your elbow and forearm and feet and then raise the hips form a straight aligminent  in the body. Keep the bottom knee bent and incontact with the ground for additional stability.",
  	 cues: "Maintain your elbow directly under your shoulder and leave your free arm for support or safety.You may place it on your hip once comfortable. Engaging the abdominals will prevent your hips from sagging. Start with a 15 second hold and progress to 60 seconds as you are able. Repeat 2-3 times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Plank (on toes)",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Commence face down with your feet shoulder width and take your bodyweight in to your forearms and elbows. Maintain your elbows directly under your shoulders. Raise your chest , hips and knees off the ground to distribute your weight over your toes and elbows only.",
  	 cues: "This is an isometric exercise, so try and hold this position with minimal movement. Engaging the abdominals will prevent your hips and lower back from sagging. Start with a 15 second hold and progress to 60 seconds as you are able. Repeat 2-3 times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Plank (on knees)",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Commence face down with your feet shoulder width and take your bodyweight in to your forearms and elbows. Maintain your elbows directly under your shoulders. Raise your chest , hips off the ground to distribute your weight over your knees, toes and elbows.",
  	 cues: "This is an isometric exercise, so try and hold this position with minimal movement. Engaging the abdominals will prevent your hips and lower back from sagging. Start with a 15 second hold and progress to 60 seconds as you are able. Repeat 2-3 times.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "V-Sit up",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Begin on the floor sitting up right with your knees tucked in to your chest. If required, place your hands by your sides to stability. Simultaneously slowly recline your torso and extend your legs out in front to engae the abs. Pause and return to start position.",
  	 cues: "Perform in slow and controlled manner and avoid momentum to complete the exercise. Inhale on the extension of the logs and exhale on the return to the start position. Can be performed on a bench or BOSU ball also. Perform 10-20 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Decline Reverse Crunch",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Lie down on a decline bench or a flat bench that has been raised on one side with a box or step lid. Grasp the bench underneath your head for stability. Slowy lift your knees towards chest, pause for a moment and then return to strating position.",
  	 cues: "Perform in slow and controlled manner and avoid momentum to complete the exercise. Keep your legs straight to increase the difficulty of the exercise. Perform 10-20 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Bosu Sit Up + Hip Flexion",
  	 body_part: "",
  	 equipment: "BOSU",
  	 description: "Lie back over the BOSU with your buttocks more towards the front edge. Place your hands behind your head with your elbows pointed outwards. Perform a slow contraction of the abs (crunch) raising the shoulder blades of the BOSU and simultaneously bring one knee towards your chest.",
  	 cues: "A contraction of the abdominals is required during this entire movement. The exercise can be done for time e.g. 30-60 secs or repetitions e.g. 30-40 reps.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Push Up + Verical Row",
  	 body_part: "",
  	 equipment: "dumbbells",
  	 description: "Grasp 2 dumbbells and set up in a push up position (toes or knees) with your hands placed slightly wider than your shoulders. Maintain alignment/posture in the torso with abs engaged and slowly pull one of the dumbbells inwards the side of the chest. Return to the start position and perform on the other side.",
  	 cues: "It is important to maintain good posture during this movement and minimise any excessive torso deviation. Exhale on the vertical rowing motion of this exercise. Perform  2 or 3 sets of 12-15 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Mountain Climber",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Commence face down wtih your feet shoulder width apart. Position your hands and straight arms directly under your shoulders to maximise stability. Raise your chest , hips and knees off the ground. While maintaining this plank position, slowly bring one knee towards the upper arm of the corresponding side for contact. Slowly return to start position and repeat on the opposite side.",
  	 cues: "Avoid any arching or sagging of the back. Encourage the use of the side abdominals to perform the movement and minimise arching of the back.   Perform 10-20 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "hanging knee raises",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Hold onto a chin up bar or similar with an overhand grip. Take all your weight in to your arms and hang the yourbody in straight alignment. Slowy lift your knees towards chest, pause for a moment and then return to strating position.",
  	 cues: "Perform in slow and controlled manner and avoid momentum to complete the exercise. Keep your legs straight to increase the difficulty of the exercise. Perform 10-20 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Standing cable rotations (woodchop)",
  	 body_part: "",
  	 equipment: "Cables",
  	 description: "Adjust the cable handle around shoulder height or slightly above. Position yourself with your feet facing forwards and your sides facing the cable handle. Stand approx 1m away and grasp the handle with extended arms and a rotation in the torso.",
  	 cues: "While keeping your arms straight, rotate against the resistance and pull the handle towards the opposite hip (furthest away from the machine). Return to start position.Keep the knees slightly bent the arms softly extended and perfrom the exercise in a controlled manner.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Wood Chop (on BOSU)",
  	 body_part: "",
  	 equipment: "BOSU and Cables",
  	 description: "Adjust the cable handle around shoulder height or slightly above. Position yourself with your feet facing forwards on  wither side of the BOSU and your sides facing the cable handle. Stand approx 1m away and grasp the handle with extended arms and a rotation in the torso.",
  	 cues: "While keeping your arms straight, rotate against the resistance and pull the handle towards the opposite hip (furthest away from the machine). Return to start position.Keep the knees slightly bent the arms softly extended and perfrom the exercise in a controlled manner.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Leg Lifts/Raises",
  	 body_part: "",
  	 equipment: "none",
  	 description: "Lie supine (face up) and place your hands by your sides or under your lower back. Raise your slightly bent legs to vertical and then engage your abs while maintaining your natural curve in spine to commence the movement. Slowly lower your legs towards the gound until you feel your lower back increase in arch, pause and return to start position.",
  	 cues: "Perform in slow and controlled manner and avoid momentum to complete the exercise. Perform 10-20 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "back extension",
  	 body_part: "Lower back",
  	 equipment: "none",
  	 description: "Position yourself face down with your hands down by your sides. Raise chest off the ground to engage the lower back and glutes.",
  	 cues: "Difficulty of the exercise can be changed by the position of the arms. Commence with hands by your sides, progress to hand unde the chin. Perform 3 sets of 15 repetitions.")
  
  
  @admin.exercises.find_or_create_by_title(
  	 title: "Reverse back extension",
  	 body_part: "Lower back",
  	 equipment: "none",
  	 description: "Position yourself face down with your hands down by your sides. Raise your extended legs to engage the glutes and lower back and then slowly return them to the start position.",
  	 cues: "This exercise shoulde be felt in the lumbar spine (erector spinae) and the glutes.  Perform 3 sets of 15 repetitions.")
end