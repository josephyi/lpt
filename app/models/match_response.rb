class MatchResponse < ActiveRecord::Base
  belongs_to :summoner
  has_many :summoner_match_stats, dependent: :destroy
end
