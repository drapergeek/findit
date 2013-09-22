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

ActiveRecord::Schema.define(version: 20130922173614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "keywords"
  end

  create_table "buildings", force: true do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "body"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "reply"
  end

  create_table "dns_names", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "item_id"
  end

  create_table "incoming_emails", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installations", force: true do |t|
    t.integer  "software_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ips", force: true do |t|
    t.string   "number"
    t.text     "info"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "item_id"
    t.integer  "building_id"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "make"
    t.string   "model"
    t.string   "processor"
    t.integer  "processor_rating"
    t.string   "ram"
    t.string   "hard_drive"
    t.string   "serial"
    t.string   "vt_tag"
    t.datetime "purchased_at"
    t.datetime "warranty_expires_at"
    t.datetime "recieved_at"
    t.string   "os"
    t.string   "type_of_item"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "operating_system_id"
    t.integer  "location_id"
    t.datetime "inventoried_at"
    t.integer  "user_id"
    t.text     "info"
    t.boolean  "in_use",              default: true, null: false
    t.datetime "surplused_at"
    t.boolean  "critical"
    t.integer  "priority"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.text     "info"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "operating_systems", force: true do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "keywords"
  end

  create_table "softwares", force: true do |t|
    t.string   "name"
    t.string   "license_key"
    t.string   "os"
    t.integer  "number_of_licenses"
    t.string   "storage_location"
    t.text     "info"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "operating_system_id"
  end

  create_table "tickets", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.integer  "priority"
    t.date     "start_date"
    t.date     "due_date"
    t.integer  "submitter_id"
    t.integer  "worker_id"
    t.integer  "project_id"
    t.integer  "area_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "last_login"
    t.string   "last_login_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "can_login"
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
