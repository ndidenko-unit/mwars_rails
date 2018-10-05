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

ActiveRecord::Schema.define(version: 2018_10_03_111036) do

  create_table "battle_to_players", force: :cascade do |t|
    t.integer "battle_id"
    t.integer "player_id"
    t.index ["battle_id"], name: "index_battle_to_players_on_battle_id"
    t.index ["player_id"], name: "index_battle_to_players_on_player_id"
  end

  create_table "battles", force: :cascade do |t|
    t.string "left_player"
    t.string "right_player"
    t.integer "left_scores", default: 100
    t.integer "right_scores", default: 100
    t.integer "turn"
    t.string "example"
    t.integer "result"
    t.integer "answer"
    t.integer "wound"
    t.integer "start_kick"
    t.integer "seconds"
    t.boolean "hit", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "games", default: 0
    t.integer "victories", default: 0
    t.integer "losses", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_players_on_name", unique: true
  end

end
