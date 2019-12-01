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
        post :create_all_resources
        get :all_companies_by_year
        get :all_years_by_company
      end
    end
  end
end
