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

ActiveRecord::Schema.define(version: 20140415185312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "role",                          default: true
    t.string   "signature"
    t.string   "api_token"
    t.integer  "company_id"
    t.boolean  "allow_reporting",               default: false
    t.boolean  "allow_agent_management",        default: false
    t.boolean  "allow_to_invite",               default: false
    t.boolean  "allow_billing_management",      default: false
    t.boolean  "allow_company_management",      default: false
    t.boolean  "allow_subscription_management", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                         default: "",    null: false
    t.string   "encrypted_password",            default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",             default: 0
  end

  add_index "agents", ["confirmation_token"], name: "index_agents_on_confirmation_token", unique: true, using: :btree
  add_index "agents", ["email"], name: "index_agents_on_email", unique: true, using: :btree
  add_index "agents", ["invitation_token"], name: "index_agents_on_invitation_token", unique: true, using: :btree
  add_index "agents", ["invitations_count"], name: "index_agents_on_invitations_count", using: :btree
  add_index "agents", ["invited_by_id"], name: "index_agents_on_invited_by_id", using: :btree
  add_index "agents", ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true, using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["company_id"], name: "index_groups_on_company_id", using: :btree
  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "groups_agents", force: true do |t|
    t.integer  "group_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_agents", ["agent_id"], name: "index_groups_agents_on_agent_id", using: :btree
  add_index "groups_agents", ["group_id"], name: "index_groups_agents_on_group_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "tickets"
    t.integer  "emails"
    t.integer  "groups"
    t.integer  "agents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "billing_period"
    t.integer  "company_id"
    t.integer  "plan_id"
    t.datetime "last_payment_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "superadmins", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "superadmins", ["confirmation_token"], name: "index_superadmins_on_confirmation_token", unique: true, using: :btree
  add_index "superadmins", ["email"], name: "index_superadmins_on_email", unique: true, using: :btree
  add_index "superadmins", ["invitation_token"], name: "index_superadmins_on_invitation_token", unique: true, using: :btree
  add_index "superadmins", ["invitations_count"], name: "index_superadmins_on_invitations_count", using: :btree
  add_index "superadmins", ["invited_by_id"], name: "index_superadmins_on_invited_by_id", using: :btree
  add_index "superadmins", ["reset_password_token"], name: "index_superadmins_on_reset_password_token", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.string   "customer_name"
    t.string   "customer_email"
    t.string   "subject"
    t.text     "message"
    t.text     "reply_email"
    t.integer  "agent_id"
    t.integer  "group_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["agent_id"], name: "index_tickets_on_agent_id", using: :btree
  add_index "tickets", ["company_id"], name: "index_tickets_on_company_id", using: :btree
  add_index "tickets", ["customer_email"], name: "index_tickets_on_customer_email", using: :btree
  add_index "tickets", ["group_id"], name: "index_tickets_on_group_id", using: :btree
  add_index "tickets", ["reply_email"], name: "index_tickets_on_reply_email", using: :btree

end
