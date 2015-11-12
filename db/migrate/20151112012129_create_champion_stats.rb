class CreateChampionStats < ActiveRecord::Migration
  def change
    create_table :champion_stats do |t|
      t.integer :champion_id
      t.integer :champion_level
      t.integer :champion_points
      t.integer :ranked_solo_games_played
      t.integer :ranked_premade_games_played
      t.integer :total_assists
      t.integer :total_champion_kills
      t.integer :total_damage_dealt
      t.integer :total_damage_taken
      t.integer :total_deaths_per_session
      t.integer :total_gold_earned
      t.integer :total_heal
      t.integer :total_minion_kills
      t.integer :total_neutral_minions_killed
      t.integer :total_sessions_played
      t.integer :total_sessions_won
      t.integer :total_sessions_lost
      t.integer :total_turrets_killed

      t.references :summoner
      t.timestamps
    end
  end
end
