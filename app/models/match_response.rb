class MatchResponse < ActiveRecord::Base
  has_many :summoner_match_stats, dependent: :destroy
end
