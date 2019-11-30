Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
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
