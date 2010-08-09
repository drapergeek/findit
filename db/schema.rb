# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100806152143) do

  create_table "announcements", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "installations", :force => true do |t|
    t.integer  "software_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ips", :force => true do |t|
    t.string   "number"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "building_id"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "make"
    t.string   "model"
    t.string   "processor"
    t.integer  "processor_rating"
    t.integer  "ram"
    t.string   "hard_drive"
    t.string   "serial"
    t.string   "vt_tag"
    t.datetime "purchased_at"
    t.datetime "warranty_expires_at"
    t.datetime "recieved_at"
    t.string   "os"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.integer  "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "softwares", :force => true do |t|
    t.string   "name"
    t.string   "license_key"
    t.string   "os"
    t.integer  "number_of_licenses"
    t.string   "storage_location"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "last_login"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_login"
  end

end