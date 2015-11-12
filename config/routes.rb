Rails.application.routes.draw do
  get '/search/:name' => 'braum#search'
end
