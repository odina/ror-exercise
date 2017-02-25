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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170225040657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "response_id"
    t.integer  "question_id"
    t.string   "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "question_type", default: 1
    t.boolean  "is_default",    default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "questions_web_surveys", force: :cascade do |t|
    t.integer "question_id"
    t.integer "web_survey_id"
  end

  add_index "questions_web_surveys", ["question_id"], name: "index_questions_web_surveys_on_question_id", using: :btree
  add_index "questions_web_surveys", ["web_survey_id"], name: "index_questions_web_surveys_on_web_survey_id", using: :btree

  create_table "respondents", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "web_survey_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "respondent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.boolean  "is_admin",               default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "web_surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "shortlink_slug"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
