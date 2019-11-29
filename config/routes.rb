Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    # get '/symbols', to: 'stocks#symbols'
    # post '/stats', to: 'stocks#stats'

    resources :companies, except: [:new, :edit] do
      collection do
        get :symbols
      end
    end

    resources :years, except: [:new, :edit]

    resources :stats_profiles, except: [:new, :edit] do
      collection do
        post :company
      end
    end
  end
end
