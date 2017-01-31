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

ActiveRecord::Schema.define(version: 20170131172237) do

  create_table "actions", force: :cascade do |t|
    t.integer  "refernce_number"
    t.datetime "date_time_created"
    t.string   "initiator"
    t.string   "owner"
    t.string   "type_ABC"
    t.date     "date_target"
    t.integer  "extentions_number", default: 0
    t.text     "description"
    t.text     "progress"
    t.text     "closeout"
    t.string   "source"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "closed_flag"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "team"
    t.string   "role"
    t.integer  "level"
    t.string   "approval_type"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

end
