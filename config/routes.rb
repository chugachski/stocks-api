Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :companies, only: [:index, :create, :destroy] do # create action will also create an associated stats profile
      post :refresh # get new data and overwrite the previos data in db, returns the company json
      get :symbols, on: :collection # get a list of the best matches from third party api
    end
    resources :stats_profiles, only: [:index, :destroy] # get all stats profiles, optionally provide year, stat, symbol
  end
end
