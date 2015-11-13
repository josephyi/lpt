class BraumController < ApplicationController
  def search
    @presenter = SummonerService.new(region: :na).search(summoner_name: params[:name])
    render :json => @presenter.process
  end

  def process_matches
    SummonerService.new(region: :na).process_match_list(summoner_id: params[:id])
    render :json => true
  end
end
