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

ActiveRecord::Schema.define(version: 2021_06_09_204144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.float "rate_to_USD", null: false
    t.string "currency_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "director_films", force: :cascade do |t|
    t.integer "director_id", null: false
    t.integer "film_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distributed_territories", force: :cascade do |t|
    t.integer "distributor_id", null: false
    t.integer "territory_id", null: false
    t.integer "film_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["distributor_id", "territory_id", "film_id"], name: "dist_terrs_index", unique: true
    t.index ["distributor_id"], name: "index_distributed_territories_on_distributor_id"
    t.index ["film_id"], name: "index_distributed_territories_on_film_id"
    t.index ["territory_id"], name: "index_distributed_territories_on_territory_id"
  end

  create_table "distributors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.string "iso_to", null: false
    t.string "iso_from", null: false
    t.float "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "films", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_films_on_title"
  end

  create_table "gross_boxes", force: :cascade do |t|
    t.decimal "local_currency_cents"
    t.integer "admissions"
    t.string "currency", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "distributed_territory_id", null: false
    t.boolean "is_ended", null: false
    t.index ["admissions"], name: "index_gross_boxes_on_admissions"
    t.index ["local_currency_cents"], name: "index_gross_boxes_on_local_currency_cents"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "period_boxes", force: :cascade do |t|
    t.integer "distributed_territory_id", null: false
    t.integer "sequence", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "currency", limit: 3, null: false
    t.decimal "local_currency_cents"
    t.integer "admissions"
    t.integer "rank"
    t.integer "screen_count"
    t.integer "location_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "period_type", null: false
    t.index ["admissions"], name: "index_period_boxes_on_admissions"
    t.index ["distributed_territory_id"], name: "index_period_boxes_on_distributed_territory_id"
    t.index ["local_currency_cents"], name: "index_period_boxes_on_local_currency_cents"
    t.index ["location_count"], name: "index_period_boxes_on_location_count"
    t.index ["screen_count"], name: "index_period_boxes_on_screen_count"
    t.index ["sequence", "distributed_territory_id", "period_type"], name: "period_boxes_index", unique: true
    t.index ["sequence"], name: "index_period_boxes_on_sequence"
    t.index ["start_date"], name: "index_period_boxes_on_start_date"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "display_region_id"
    t.boolean "is_master_region", null: false
    t.integer "display_priority"
  end

  create_table "release_dates", force: :cascade do |t|
    t.date "date"
    t.string "release_format", null: false
    t.integer "distributed_territory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "context"
    t.index ["date"], name: "index_release_dates_on_date"
    t.index ["distributed_territory_id", "release_format"], name: "release_dates_index", unique: true
  end

  create_table "territories", force: :cascade do |t|
    t.string "name", null: false
    t.string "weekend_start", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "region_id", null: false
    t.string "default_currency", limit: 3, null: false
    t.integer "continent_id"
    t.boolean "is_displayed", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "email", null: false
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

end
