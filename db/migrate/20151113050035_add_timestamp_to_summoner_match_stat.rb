class AddTimestampToSummonerMatchStat < ActiveRecord::Migration
  def change
    add_column :summoner_match_stats, :timestamp, :bigint
  end
end
