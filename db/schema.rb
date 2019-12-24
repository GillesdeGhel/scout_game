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

ActiveRecord::Schema.define(version: 2019_12_24_125249) do

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
    t.integer "defense_building_multiplicator"
  end

  create_table "constructions", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "building_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "defenses", force: :cascade do |t|
    t.integer "patrol_id"
    t.integer "city_id"
    t.integer "man_power"
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
    t.integer "total_gains"
  end

  create_table "troops", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "turns_holding_paris"
    t.boolean "hold_paris"
  end

end
