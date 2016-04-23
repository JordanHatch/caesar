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

ActiveRecord::Schema.define(version: 20160423061019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "owner",   null: false
    t.string "change",  null: false
    t.string "address"
    t.string "url"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "application_id", null: false
    t.string  "intent",         null: false
    t.string  "name",           null: false
    t.string  "email"
    t.string  "secret",         null: false
  end

  add_index "votes", ["application_id"], name: "index_votes_on_application_id", using: :btree

end
