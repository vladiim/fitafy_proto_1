# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120228075256) do

  create_table "bookings", :force => true do |t|
    t.integer  "trainer_id"
    t.integer  "client_id"
    t.date     "wo_date"
    t.time     "wo_time"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "workout_id"
  end

  add_index "bookings", ["client_id"], :name => "index_bookings_on_client_id"
  add_index "bookings", ["trainer_id"], :name => "index_bookings_on_trainer_id"
  add_index "bookings", ["wo_date"], :name => "index_bookings_on_wo_date"
  add_index "bookings", ["wo_time"], :name => "index_bookings_on_wo_time"

  create_table "exercises", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "body_part"
    t.string   "equipment"
    t.text     "cues"
    t.integer  "booking_id"
    t.integer  "sets",        :default => 0
    t.integer  "reps",        :default => 0
    t.boolean  "admin",       :default => false
  end

  add_index "exercises", ["body_part"], :name => "index_exercises_on_body_part"
  add_index "exercises", ["equipment"], :name => "index_exercises_on_equipment"
  add_index "exercises", ["title"], :name => "index_exercises_on_title"
  add_index "exercises", ["user_id", "title"], :name => "index_exercises_on_user_id_and_title"
  add_index "exercises", ["user_id"], :name => "index_exercises_on_user_id"

  create_table "exercises_workouts", :id => false, :force => true do |t|
    t.integer "workout_id"
    t.integer "exercise_id"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "trainer_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "invitations", ["recipient_email"], :name => "index_invitations_on_recipient_email"
  add_index "invitations", ["trainer_id"], :name => "index_invitations_on_trainer_id"

  create_table "relationships", :force => true do |t|
    t.integer  "trainer_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted",   :default => false
    t.boolean  "declined",   :default => false
  end

  add_index "relationships", ["client_id"], :name => "index_relationships_on_client_id"
  add_index "relationships", ["trainer_id", "client_id"], :name => "index_relationships_on_trainer_id_and_client_id", :unique => true
  add_index "relationships", ["trainer_id"], :name => "index_relationships_on_trainer_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email",                                :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                                 :null => false
    t.boolean  "admin",             :default => false
    t.integer  "invitation_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "workouts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["title"], :name => "index_workouts_on_title"
  add_index "workouts", ["user_id", "title"], :name => "index_workouts_on_user_id_and_title"
  add_index "workouts", ["user_id"], :name => "index_workouts_on_user_id"

end
