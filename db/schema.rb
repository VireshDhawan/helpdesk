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

ActiveRecord::Schema.define(version: 20140503083833) do

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
    t.boolean  "allow_groups_management",       default: false
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

  create_table "filters", force: true do |t|
    t.string   "from_email"
    t.string   "delivered_to"
    t.string   "subject_with_keywords"
    t.string   "body_with_keywords"
    t.boolean  "archive"
    t.boolean  "trash"
    t.boolean  "spam"
    t.integer  "label_id"
    t.integer  "group_id"
    t.integer  "agent_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filters", ["agent_id"], name: "index_filters_on_agent_id", using: :btree
  add_index "filters", ["body_with_keywords"], name: "index_filters_on_body_with_keywords", using: :btree
  add_index "filters", ["company_id"], name: "index_filters_on_company_id", using: :btree
  add_index "filters", ["delivered_to"], name: "index_filters_on_delivered_to", using: :btree
  add_index "filters", ["from_email"], name: "index_filters_on_from_email", using: :btree
  add_index "filters", ["group_id"], name: "index_filters_on_group_id", using: :btree
  add_index "filters", ["label_id"], name: "index_filters_on_label_id", using: :btree
  add_index "filters", ["subject_with_keywords"], name: "index_filters_on_subject_with_keywords", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["company_id"], name: "index_groups_on_company_id", using: :btree
  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree

  create_table "groups_agents", force: true do |t|
    t.integer  "group_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_agents", ["agent_id"], name: "index_groups_agents_on_agent_id", using: :btree
  add_index "groups_agents", ["group_id"], name: "index_groups_agents_on_group_id", using: :btree

  create_table "labels", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["company_id"], name: "index_labels_on_company_id", using: :btree
  add_index "labels", ["name"], name: "index_labels_on_name", using: :btree

  create_table "labels_tickets", id: false, force: true do |t|
    t.integer "ticket_id"
    t.integer "label_id"
  end

  add_index "labels_tickets", ["ticket_id", "label_id"], name: "index_labels_tickets_on_ticket_id_and_label_id", using: :btree

  create_table "mailgun_apis", force: true do |t|
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailgun_apis", ["key"], name: "index_mailgun_apis_on_key", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.boolean  "unassigned_tickets",           default: false
    t.boolean  "assigned_tickets",             default: true
    t.boolean  "assigned_group",               default: true
    t.boolean  "reply_all",                    default: false
    t.boolean  "reply_on_my_tickets",          default: true
    t.boolean  "reply_on_my_group_tickets",    default: true
    t.boolean  "all_comments",                 default: false
    t.boolean  "comments_on_my_tickets",       default: true
    t.boolean  "comments_on_my_group_tickets", default: true
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["agent_id"], name: "index_notifications_on_agent_id", unique: true, using: :btree
  add_index "notifications", ["all_comments"], name: "index_notifications_on_all_comments", using: :btree
  add_index "notifications", ["assigned_group"], name: "index_notifications_on_assigned_group", using: :btree
  add_index "notifications", ["assigned_tickets"], name: "index_notifications_on_assigned_tickets", using: :btree
  add_index "notifications", ["comments_on_my_group_tickets"], name: "index_notifications_on_comments_on_my_group_tickets", using: :btree
  add_index "notifications", ["comments_on_my_tickets"], name: "index_notifications_on_comments_on_my_tickets", using: :btree
  add_index "notifications", ["reply_all"], name: "index_notifications_on_reply_all", using: :btree
  add_index "notifications", ["reply_on_my_group_tickets"], name: "index_notifications_on_reply_on_my_group_tickets", using: :btree
  add_index "notifications", ["reply_on_my_tickets"], name: "index_notifications_on_reply_on_my_tickets", using: :btree
  add_index "notifications", ["unassigned_tickets"], name: "index_notifications_on_unassigned_tickets", using: :btree

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

  add_index "plans", ["name"], name: "index_plans_on_name", unique: true, using: :btree

  create_table "snippets", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "tags"
    t.boolean  "scope"
    t.integer  "snippetable_id"
    t.string   "snippetable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snippets", ["content"], name: "index_snippets_on_content", using: :btree
  add_index "snippets", ["name"], name: "index_snippets_on_name", using: :btree
  add_index "snippets", ["snippetable_id"], name: "index_snippets_on_snippetable_id", using: :btree
  add_index "snippets", ["snippetable_type"], name: "index_snippets_on_snippetable_type", using: :btree
  add_index "snippets", ["tags"], name: "index_snippets_on_tags", using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "billing_period"
    t.integer  "company_id"
    t.integer  "plan_id"
    t.datetime "last_payment_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["billing_period"], name: "index_subscriptions_on_billing_period", using: :btree
  add_index "subscriptions", ["company_id"], name: "index_subscriptions_on_company_id", using: :btree
  add_index "subscriptions", ["last_payment_at"], name: "index_subscriptions_on_last_payment_at", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree

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

  create_table "ticket_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_categories", ["name"], name: "index_ticket_categories_on_name", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "customer_name"
    t.string   "customer_email"
    t.string   "subject"
    t.text     "message"
    t.text     "reply_email"
    t.integer  "agent_id"
    t.integer  "group_id"
    t.integer  "company_id"
    t.integer  "ticket_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["agent_id"], name: "index_tickets_on_agent_id", using: :btree
  add_index "tickets", ["company_id"], name: "index_tickets_on_company_id", using: :btree
  add_index "tickets", ["customer_email"], name: "index_tickets_on_customer_email", using: :btree
  add_index "tickets", ["group_id"], name: "index_tickets_on_group_id", using: :btree
  add_index "tickets", ["reply_email"], name: "index_tickets_on_reply_email", using: :btree
  add_index "tickets", ["ticket_category_id"], name: "index_tickets_on_ticket_category_id", using: :btree

end
