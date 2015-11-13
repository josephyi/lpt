Rails.application.routes.draw do
  get '/search/:name' => 'braum#search'
  get '/process/:id' => 'braum#process_matches'
end
