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

ActiveRecord::Schema.define(:version => 20120324234955) do

  create_table "alerts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "start"
    t.integer  "timeout"
    t.string   "fallback_name"
    t.string   "fallback_phone"
    t.string   "fallback_phone_normalised"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "reason"
    t.string   "sid"
    t.string   "prompt"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "messages", :force => true do |t|
    t.boolean  "incoming"
    t.string   "from"
    t.string   "to"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "sid"
    t.boolean  "delivered"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "normalised_phone"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
