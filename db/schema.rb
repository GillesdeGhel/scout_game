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

ActiveRecord::Schema.define(version: 2021_05_26_184702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attacks", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "city_id"
    t.integer "man_power"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.string "usage"
    t.integer "durability"
    t.integer "cost"
    t.float "multiplicator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "troop_id"
    t.integer "defense_men_power"
    t.float "defense_building_multiplicator"
    t.boolean "pillaged", default: false
    t.integer "pillage_count", default: 0
    t.integer "previous_total_attack", default: 0
    t.integer "previous_total_defense", default: 0
    t.integer "population", default: 0
    t.integer "fortification_level", default: 0
    t.float "tax_multiplicator", default: 0.0
    t.integer "passive_points_earning", default: 0
    t.integer "development_level", default: 0
    t.integer "religious_level", default: 0
  end

  create_table "constructions", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "building_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "durability"
  end

  create_table "defenses", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "city_id"
    t.integer "man_power"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guilds", force: :cascade do |t|
    t.string "name"
    t.float "attack_power_multiplicator", default: 1.0
    t.float "defense_power_multiplicator", default: 1.0
    t.float "attack_construction_cost_multiplicator", default: 1.0
    t.float "defense_construction_cost_multiplicator", default: 1.0
    t.float "mining_multiplicator", default: 1.0
    t.float "revenues_multiplicator", default: 1.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "minings", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "man_power"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patrols", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "troop_id"
    t.integer "money"
    t.boolean "hold_regional_capital"
    t.integer "total_gains", default: 0
    t.integer "guild_id"
    t.boolean "guild_changed", default: false
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "minings_winnings", default: 0
    t.integer "attack_winnings", default: 0
    t.integer "defense_losses", default: 0
    t.integer "base_revenues", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paris_winning", default: 0
    t.string "event"
  end

  create_table "troops", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "turns_holding_paris", default: 0
    t.boolean "hold_paris"
    t.string "country_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "troop_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
