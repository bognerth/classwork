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

ActiveRecord::Schema.define(:version => 20121122123340) do

  create_table "answer_students", :force => true do |t|
    t.integer  "answer_id"
    t.integer  "student_id"
    t.integer  "question_id"
    t.integer  "test_id"
    t.integer  "test_student_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    #answer_student answer_id:integer student_id:integer test_id:integer
  end

  create_table "answers", :force => true do |t|
    t.text     "text"
    t.integer  "question_id"
    t.integer  "points"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    #answer description:text question_id:text points:integer
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.text     "text"
    t.integer  "category_id"
    t.boolean  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "current_sessions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "student_id"
    t.integer  "group_id"
    t.text  "courses"
    t.text  "tests"
    t.string   "email"
    t.string   "name"
    t.string   "state"
    t.integer  "c_category_id"
    t.integer  "c_test_id"
    t.integer  "c_test_student_id"
    t.integer  "c_count_questions"
    t.integer  "c_duration"
    t.datetime "c_start"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "test_events", :force => true do |t|
    t.integer  "test_id"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "test_students", :force => true do |t|
    t.integer  "test_id"
    t.integer  "student_id"
    t.integer  "points"
    t.integer  "current_question_id"
    t.integer  "count_questions"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tests", :force => true do |t|
    t.string   "description"
    t.integer  "course_id"
    t.integer  "category_id"
    t.integer  "duration"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
