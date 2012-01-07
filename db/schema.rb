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

ActiveRecord::Schema.define(:version => 20120107011729) do

  create_table "relationships", :force => true do |t|
    t.integer  "trainer_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["client_id"], :name => "index_relationships_on_client_id"
  add_index "relationships", ["trainer_id", "client_id"], :name => "index_relationships_on_trainer_id_and_client_id", :unique => true
  add_index "relationships", ["trainer_id"], :name => "index_relationships_on_trainer_id"

  create_table "users", :force => true do |t|
    t.string   "username",          :null => false
    t.string   "email",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "workouts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["title"], :name => "index_workouts_on_title"
  add_index "workouts", ["user_id", "title"], :name => "index_workouts_on_user_id_and_title"
  add_index "workouts", ["user_id"], :name => "index_workouts_on_user_id"

end
