class BraumController < ApplicationController
  def search
    @presenter = SummonerService.new(region: :na).search(summoner_name: params[:name])
    render :json => @presenter.process
  end
end
