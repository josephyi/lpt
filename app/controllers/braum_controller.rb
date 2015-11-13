class BraumController < ApplicationController
  def search
    @presenter = SummonerService.new(region: :na).search(summoner_name: params[:name])
    SummonerService.new(region: :na).process_match_list(summoner_id: @presenter.id)
    render :json => @presenter.process
  end

  def process_matches
    @summoner = Summoner.where(name: params[:name]).first
    SummonerService.new(region: :na).process_match_list(summoner_id: @summoner.id)
    render :json => @summoner.time_series_process
  end
end
