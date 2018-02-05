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

ActiveRecord::Schema.define(version: 20180205235054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "organization_id",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.boolean  "authorized",      default: false
    t.index ["organization_id"], name: "index_assignments_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_assignments_on_user_id", using: :btree
  end

  create_table "authorized_jobs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_authorized_jobs_on_job_id", using: :btree
    t.index ["user_id"], name: "index_authorized_jobs_on_user_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "venue_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "gcal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partnerships", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.integer  "venue_id",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_partnerships_on_organization_id", using: :btree
    t.index ["venue_id"], name: "index_partnerships_on_venue_id", using: :btree
  end

  create_table "preferred_days", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "preferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferred_days_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "shifts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "show_id"
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "job_id"
    t.index ["show_id"], name: "index_shifts_on_show_id", using: :btree
    t.index ["user_id"], name: "index_shifts_on_user_id", using: :btree
  end

  create_table "shows", force: :cascade do |t|
    t.datetime "doors"
    t.datetime "start"
    t.datetime "show_end"
    t.integer  "venue_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "headliner"
    t.string   "info"
    t.integer  "organization_id"
    t.decimal  "recoup"
    t.decimal  "payout"
    t.string   "event_link"
    t.string   "tickets_link"
    t.decimal  "door_price"
    t.boolean  "all_ages"
    t.integer  "booked_by_id"
    t.date     "date"
    t.index ["organization_id"], name: "index_shows_on_organization_id", using: :btree
    t.index ["venue_id"], name: "index_shows_on_venue_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "hooks"
  end

end
