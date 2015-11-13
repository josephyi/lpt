class SummonerMatchStat < ActiveRecord::Base
  belongs_to :summoner
  belongs_to :match_response
end
