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

ActiveRecord::Schema.define(version: 20170224101923) do

  create_table "actions", force: :cascade do |t|
    t.integer  "reference_number"
    t.datetime "date_time_created"
    t.string   "initiator"
    t.string   "owner"
    t.string   "type_ABC"
    t.date     "date_target"
    t.integer  "extensions_number",   default: 0
    t.text     "description"
    t.text     "progress"
    t.text     "closeout"
    t.string   "source"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "closed_flag",         default: false
    t.boolean  "close_request_flag",  default: false
    t.boolean  "extend_request_flag", default: false
    t.boolean  "accepted_flag",       default: false
    t.text     "updatetext"
    t.index ["event_id"], name: "index_actions_on_event_id"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "approval_routes", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "document_id"
    t.index ["document_id"], name: "index_approval_routes_on_document_id"
  end

  create_table "approvers", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "approval_route_id"
    t.index ["approval_route_id"], name: "index_approvers_on_approval_route_id"
  end

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "approval_route_id"
    t.index ["approval_route_id"], name: "index_authors_on_approval_route_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.integer  "issue_number"
    t.boolean  "checked_out_flag"
    t.string   "author"
    t.string   "reviewer"
    t.string   "approver"
    t.boolean  "reviewed_flag"
    t.boolean  "approved_flag"
    t.boolean  "issued_flag"
    t.datetime "issued_on"
    t.datetime "review_period"
    t.datetime "due_date"
    t.datetime "review_duration"
    t.datetime "reviewed_on"
    t.datetime "approved_on"
    t.string   "stored_doc"
    t.string   "stored_pdf"
    t.boolean  "review_request_flag"
    t.boolean  "approve_request_flag"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "file_location_doc"
    t.string   "file_location_pdf"
    t.string   "status"
    t.integer  "doc_number"
    t.text     "comments"
    t.string   "doc_type"
    t.string   "doc_sub_type"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "reference_number"
    t.datetime "date_raised"
    t.datetime "date_closed"
    t.string   "location"
    t.string   "building"
    t.string   "area"
    t.text     "what_happened"
    t.text     "immediate_actions"
    t.string   "classification"
    t.string   "root_cause"
    t.decimal  "bc_number"
    t.boolean  "injury_flag"
    t.boolean  "safety_flag"
    t.boolean  "environmental_flag"
    t.boolean  "security_flag"
    t.boolean  "quality_flag"
    t.boolean  "closed_flag",        default: false
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "report_form"
    t.string   "guest_name"
    t.boolean  "acknowledged_flag"
    t.boolean  "close_request_flag"
    t.text     "follow_up"
    t.string   "file_location"
    t.string   "reported_by"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "reviewers", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "approval_route_id"
    t.index ["approval_route_id"], name: "index_reviewers_on_approval_route_id"
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
    t.boolean  "active_flag"
    t.text     "comment"
    t.string   "department"
    t.integer  "author_id"
    t.integer  "reviewer_id"
    t.integer  "approver_id"
    t.index ["approver_id"], name: "index_users_on_approver_id"
    t.index ["author_id"], name: "index_users_on_author_id"
    t.index ["reviewer_id"], name: "index_users_on_reviewer_id"
  end

end
