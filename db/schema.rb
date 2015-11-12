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

ActiveRecord::Schema.define(version: 20151112024909) do

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

end
