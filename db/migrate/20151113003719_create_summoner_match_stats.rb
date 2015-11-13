class CreateSummonerMatchStats < ActiveRecord::Migration
  def change
    create_table :summoner_match_stats do |t|
      t.references :summoner, index: true, foreign_key: true
      t.references :match_response, index: true, foreign_key: true
      t.integer :champion_id
      t.string :role
      t.string :lane
      t.boolean :winner
      t.integer :team_id
      t.integer :participant_index
      t.integer :kills
      t.integer :deaths
      t.integer :assists
      t.integer :wards_placed
      t.integer :wards_killed
      t.integer :minions_killed
      t.integer :neutral_minions_killed

      t.timestamps null: false
    end
  end
end
