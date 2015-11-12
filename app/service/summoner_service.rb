class SummonerService

  def initialize(region: :na)
    @client = Taric.client(region: region)
  end

  def search(summoner_name: )
    response = @client.summoners_by_names(summoner_names: summoner_name)[summoner_name]
    persisted = Summoner.where(region: response['region'.freeze]).where(summoner_id: response['id'.freeze]).first

    if persisted.nil? && response.present?
      create_summoner(response)
    else

    end
  end

  private

  def create_summoner(response)
    Summoner.create(summoner_id: response['id'],
                    name: response['name'],
                    profile_icon_id: response['profileIconId'],
                    summoner_level: response['summonerLevel'],
                    revision_date: response['revisionDate']
    )
  end
end