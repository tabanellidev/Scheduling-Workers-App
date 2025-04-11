# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_17_133211) do
  create_table "cleaners", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "codfis"
    t.string "residence"
    t.string "license"
    t.date "birthdate"
    t.date "hired"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "email"
    t.integer "hours_required"
    t.integer "internaln"
  end

  create_table "jobs", force: :cascade do |t|
    t.datetime "date"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cleaner_id", null: false
    t.integer "site_id", null: false
    t.string "notes"
    t.index ["cleaner_id"], name: "index_jobs_on_cleaner_id"
    t.index ["site_id"], name: "index_jobs_on_site_id"
  end

  create_table "repeatable_jobs", force: :cascade do |t|
    t.integer "day"
    t.string "hour"
    t.float "duration"
    t.integer "cleaner_id", null: false
    t.integer "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.index ["cleaner_id"], name: "index_repeatable_jobs_on_cleaner_id"
    t.index ["site_id"], name: "index_repeatable_jobs_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "nome"
    t.integer "time_required"
    t.string "location"
    t.text "requests"
    t.string "owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.string "name"
    t.string "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "jobs", "cleaners"
  add_foreign_key "jobs", "sites"
  add_foreign_key "repeatable_jobs", "cleaners"
  add_foreign_key "repeatable_jobs", "sites"
end
