class SummonerService

  def initialize(region: :na)
    @region = region
    @client = Taric.client(region: region)
  end

  def search(summoner_name: )
    summoner = find_or_create_summoner(summoner_name: summoner_name, region: @region.to_s)
    process_match_list(summoner_id: summoner.id)

    summoner
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
    summoner
  end

  def build_champ_stats(summoner_id:, season: 'SEASON2015')
    champion_mastery_hash = Hash[@client.champion_mastery_all(summoner_id: summoner_id).map{|e| [e['championId'], e]}]

    @client.ranked_stats(summoner_id: summoner_id, season: season)['champions'].map{ |c|
      ChampionStat.new(champion_id: c['id'],
                       champion_level: champion_mastery_hash[c['id']].present? ? champion_mastery_hash[c['id']]['championLevel'] : 0,
                       champion_points: champion_mastery_hash[c['id']].present? ?  champion_mastery_hash[c['id']]['championPoints'] : 0,
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

  def find_or_create_summoner(summoner_name: , region: )
    response = @client.summoners_by_names(summoner_names: summoner_name)[summoner_name]
    summoner = Summoner.where(region: region, summoner_id: response['id']).first
    summoner || create_summoner(region: region, response: response)
  end

  def process_match_list(summoner_id:)
    match_list_response = MatchListResponse.find_or_create_by(summoner_id: summoner_id) do |match_list_response|
      match_list_response.response = @client.match_list(ranked_queues: 'RANKED_SOLO_5x5', seasons: 'SEASON2015', summoner_id: Summoner.find(summoner_id).summoner_id)
    end

    match_ids = match_list_response.response['matches'].map{|m| m['matchId']}
    persisted_match_ids = MatchResponse.where(match_id: match_ids).pluck(:match_id)
    diff_ids = match_ids - persisted_match_ids

    retry_ids = []
    if diff_ids.present?
      diff_ids.each do |id|
        MatchResponse.create(match_id: id, response: @client.match(id: id)) rescue retry_ids << id
      end

      retry_ids.each do |id|
        MatchResponse.create(match_id: id, response: @client.match(id: id)) rescue Rails.logger.info "******** #{id}"
      end
    end

  end
end