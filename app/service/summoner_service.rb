class SummonerService

  def initialize(region: :na)
    @region = region
    @client = Taric.client(region: region)
  end

  def search(summoner_name: )
    response = @client.summoners_by_names(summoner_names: summoner_name)[summoner_name]
    persisted = Summoner.where(region: response['region']).where(summoner_id: response['id']).first
    persisted = create_summoner(region: @region.to_s, response: response)  if persisted.nil? && response.present?
    persisted
  end

  private

  def create_summoner(region: , response: )
    summoner = Summoner.new(region: region,
                    summoner_id: response['id'],
                    name: response['name'],
                    profile_icon_id: response['profileIconId'],
                    summoner_level: response['summonerLevel'],
                    revision_date: response['revisionDate']
    )

    summoner.champion_stats << build_champ_stats(summoner_id: response['id'])
    summoner.save
  end

  def build_champ_stats(summoner_id:, season: 'SEASON2015')
    champion_mastery_hash = Hash[@client.champion_mastery_all(summoner_id: summoner_id).map{|e| [e['championId'], e]}]

    @client.ranked_stats(summoner_id: summoner_id, season: season)['champions'].map{ |c|
      ChampionStat.new(champion_id: c['id'],
                       champion_level: champion_mastery_hash[c['id']].present? ? champion_mastery_hash[c['id']]['championLevel'] : nil,
                       champion_points: champion_mastery_hash[c['id']].present? ?  champion_mastery_hash[c['id']]['championPoints'] : nil,
                       ranked_solo_games_played:  c['stats']['rankedSoloGamesPlayed'],
                       ranked_premade_games_played: c['stats']['rankedPremadeGamesPlayed'],
                       total_assists: c['stats']['totalAssists'],
                       total_champion_kills:  c['stats']['totalChampionKills'],
                       total_damage_dealt: c['stats']['totalDamageDealt'],
                       total_damage_taken: c['stats']['totalDamageTaken'],
                       total_deaths_per_session: c['stats']['totalDeathsPerSession'],
                       total_gold_earned: c['stats']['totalGoldEarned'],
                       total_minion_kills: c['stats']['totalMinionKills'],
                       total_neutral_minions_killed: c['stats']['totalNeutralMinionsKilled'],
                       total_sessions_played:  c['stats']['totalSessionsPlayed'],
                       total_sessions_won:  c['stats']['totalSessionsWon'],
                       total_sessions_lost: c['stats']['totalSessionsLost'],
                       total_turrets_killed: c['stats']['totalTurretsKilled']
      )
    } 
  end
end