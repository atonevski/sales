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

ActiveRecord::Schema.define(version: 20160719092619) do

  create_table "agents", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "category"
    t.integer  "count"
    t.decimal  "amount",     precision: 10, scale: 2
    t.text     "desc"
    t.integer  "game_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "categories", ["game_id"], name: "index_categories_on_game_id"

  create_table "commission_letters", force: :cascade do |t|
    t.boolean  "invoiced_correctly"
    t.decimal  "incorrect_sum",      precision: 12, scale: 2
    t.date     "invoice_date"
    t.integer  "user_id"
    t.integer  "agent_id"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "invoice_id"
  end

  add_index "commission_letters", ["agent_id"], name: "index_commission_letters_on_agent_id"
  add_index "commission_letters", ["user_id"], name: "index_commission_letters_on_user_id"

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.text     "desc"
    t.integer  "parent"
    t.decimal  "price",      precision: 6, scale: 2
    t.integer  "volume"
    t.decimal  "commission", precision: 4, scale: 3
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "role"
    t.string   "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id"

  create_table "sales", force: :cascade do |t|
    t.date     "date"
    t.decimal  "sales",       precision: 12, scale: 2
    t.decimal  "payout",      precision: 12, scale: 2
    t.integer  "terminal_id"
    t.integer  "agent_id"
    t.integer  "game_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "sales", ["agent_id"], name: "index_sales_on_agent_id"
  add_index "sales", ["date"], name: "index_sales_on_date"
  add_index "sales", ["game_id"], name: "index_sales_on_game_id"
  add_index "sales", ["terminal_id"], name: "index_sales_on_terminal_id"

  create_table "terminals", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "address"
    t.string   "tel"
    t.decimal  "lat",        precision: 12, scale: 9
    t.decimal  "lng",        precision: 12, scale: 9
    t.integer  "agent_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "terminals", ["agent_id"], name: "index_terminals_on_agent_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.datetime "archived_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
