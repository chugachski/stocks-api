Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    get '/symbols', to: 'stocks#symbols'
    post '/stats', to: 'stocks#stats'

    resources :companies, only: [:index, :show, :create, :update, :destroy]
    resources :years, only: [:index, :show, :create, :update, :destroy]
    resources :stats_profiles, only: [:index, :show, :create, :update, :destroy]
  end
end
