class Api::StatsProfilesController < ApplicationController
    before_action :set_stats_profile, only: [:show, :update, :destroy]

    after_action only: [:index, :all_companies_by_year, :all_years_by_company] do
      set_pagination_headers :stats_profiles
    end

    # GET /api/stats_profiles
    def index
      @stats_profiles, @display_stat = StatsProfile.search(stats_profile_params)
    end

    # DELETE /api/stats_profiles/1
    def destroy
      @stats_profile.destroy
      head :no_content
    end

    private
    def set_stats_profile
      @stats_profile = StatsProfile.find(params[:id])
    end

    def stats_profile_params
      params.permit(:year, :symbol, :stat, :order, :page, :per_page)
    end
end
