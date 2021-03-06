# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_03_113439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctor_specialities", force: :cascade do |t|
    t.bigint "speciality_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_doctor_specialities_on_doctor_id"
    t.index ["speciality_id"], name: "index_doctor_specialities_on_speciality_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "specialty"
    t.string "address"
    t.string "city"
    t.string "phone"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "dt"
    t.integer "duration"
    t.string "appointment_type"
    t.bigint "user_id"
    t.bigint "doctor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_schedules_on_doctor_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "firstname"
    t.string "lastname"
    t.string "phone"
    t.datetime "birthdate"
    t.boolean "is_doctor"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doctor_specialities", "doctors"
  add_foreign_key "doctor_specialities", "specialities"
  add_foreign_key "doctors", "users"
  add_foreign_key "schedules", "doctors"
  add_foreign_key "schedules", "users"
end
