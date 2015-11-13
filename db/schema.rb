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

ActiveRecord::Schema.define(version: 20151113003719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "champion_stats", force: :cascade do |t|
    t.integer  "champion_id"
    t.integer  "champion_level"
    t.integer  "champion_points"
    t.integer  "ranked_solo_games_played"
    t.integer  "ranked_premade_games_played"
    t.integer  "total_assists"
    t.integer  "total_champion_kills"
    t.integer  "total_damage_dealt"
    t.integer  "total_damage_taken"
    t.integer  "total_deaths_per_session"
    t.integer  "total_gold_earned"
    t.integer  "total_heal"
    t.integer  "total_minion_kills"
    t.integer  "total_neutral_minions_killed"
    t.integer  "total_sessions_played"
    t.integer  "total_sessions_won"
    t.integer  "total_sessions_lost"
    t.integer  "total_turrets_killed"
    t.integer  "summoner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_type",    null: false
    t.string   "event_details"
    t.integer  "summoner_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "match_list_responses", force: :cascade do |t|
    t.integer  "summoner_id"
    t.jsonb    "response"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "match_list_responses", ["response"], name: "index_match_list_responses_on_response", using: :gin
  add_index "match_list_responses", ["summoner_id"], name: "index_match_list_responses_on_summoner_id", using: :btree

  create_table "match_responses", force: :cascade do |t|
    t.integer  "match_id"
    t.jsonb    "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "match_responses", ["match_id"], name: "index_match_responses_on_match_id", using: :btree
  add_index "match_responses", ["response"], name: "index_match_responses_on_response", using: :gin

  create_table "summoner_match_stats", force: :cascade do |t|
    t.integer  "summoner_id"
    t.integer  "match_response_id"
    t.integer  "champion_id"
    t.string   "role"
    t.string   "lane"
    t.boolean  "winner"
    t.integer  "team_id"
    t.integer  "participant_index"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "wards_placed"
    t.integer  "wards_killed"
    t.integer  "minions_killed"
    t.integer  "neutral_minions_killed"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "summoner_match_stats", ["match_response_id"], name: "index_summoner_match_stats_on_match_response_id", using: :btree
  add_index "summoner_match_stats", ["summoner_id"], name: "index_summoner_match_stats_on_summoner_id", using: :btree

  create_table "summoners", force: :cascade do |t|
    t.integer  "summoner_id"
    t.string   "name"
    t.string   "region"
    t.integer  "profile_icon_id"
    t.integer  "summoner_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "revision_date",   limit: 8
  end

  add_foreign_key "summoner_match_stats", "match_responses"
  add_foreign_key "summoner_match_stats", "summoners"
end
