class Summoner < ActiveRecord::Base
  has_many :champion_stats, dependent: :destroy
  has_many :events, dependent: :destroy
end
