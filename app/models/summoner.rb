class Summoner < ActiveRecord::Base
  has_many :champion_stats, dependent: :destroy
end
