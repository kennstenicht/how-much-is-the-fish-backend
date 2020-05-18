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

ActiveRecord::Schema.define(version: 2020_05_08_183841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_events", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "artist_id", null: false
    t.index ["artist_id"], name: "index_artists_events_on_artist_id"
    t.index ["event_id"], name: "index_artists_events_on_event_id"
  end

  create_table "artists_workspaces", id: false, force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "artist_id", null: false
    t.index ["artist_id"], name: "index_artists_workspaces_on_artist_id"
    t.index ["workspace_id"], name: "index_artists_workspaces_on_workspace_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.integer "guests"
    t.string "name"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "events_venues", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "venue_id", null: false
    t.index ["event_id"], name: "index_events_venues_on_event_id"
    t.index ["venue_id"], name: "index_events_venues_on_venue_id"
  end

  create_table "events_workspaces", id: false, force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_events_workspaces_on_event_id"
    t.index ["workspace_id"], name: "index_events_workspaces_on_workspace_id"
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_expense_categories_on_venue_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.string "note"
    t.decimal "price"
    t.integer "quantity"
    t.bigint "expense_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_category_id"], name: "index_expenses_on_expense_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_workspaces", id: false, force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_users_workspaces_on_user_id"
    t.index ["workspace_id"], name: "index_users_workspaces_on_workspace_id"
  end

  create_table "venues", force: :cascade do |t|
    t.integer "capacity"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues_workspaces", id: false, force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "venue_id", null: false
    t.index ["venue_id"], name: "index_venues_workspaces_on_venue_id"
    t.index ["workspace_id"], name: "index_venues_workspaces_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "venues"
  add_foreign_key "expense_categories", "venues"
end
