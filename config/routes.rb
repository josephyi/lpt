Rails.application.routes.draw do
  get '/search/:name' => 'braum#search'
  get '/process/:name' => 'braum#process_matches'
end
