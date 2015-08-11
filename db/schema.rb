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

ActiveRecord::Schema.define(version: 20150811050344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "username",           null: false
    t.string   "encrypted_password", null: false
    t.string   "salt",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "categories", ["id"], name: "index_categories_on_id", using: :btree

  create_table "confirmations", force: :cascade do |t|
    t.string   "token"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confirmations", ["id"], name: "index_confirmations_on_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "uuid"
    t.string   "lat"
    t.string   "long"
    t.string   "number"
    t.string   "street"
    t.string   "suburb"
    t.string   "state"
    t.string   "postcode"
    t.string   "country"
    t.string   "formatted_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["id"], name: "index_locations_on_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  add_index "recipients", ["id"], name: "index_recipients_on_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "uuid"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "sent_at"
    t.integer  "location_id"
    t.string   "image"
  end

  add_index "reports", ["id"], name: "index_reports_on_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "postcode"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",  default: false
  end

  add_index "users", ["id"], name: "index_users_on_id", using: :btree

end
