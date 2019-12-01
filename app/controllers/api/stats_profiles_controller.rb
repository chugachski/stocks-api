class Api::StatsProfilesController < ApplicationController
    before_action :set_stats_profile, only: [:show, :update, :destroy]

    # GET /api/stats_profiles
    def index
      # @stats_profiles = StatsProfile.searching(params)
      @stats_profiles = StatsProfile.all
    end

    # GET /api/stats_profiles/1
    def show
    end

    # POST /api/stats_profiles
    def create
      @stats_profile = StatsProfile.new(stats_profile_params)

      if @stats_profile.save
        render :show, status: :created, location: api_stats_profile_url(@stats_profile)
      else
        render json: @stats_profile.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/stats_profiles/1
    def update
      if @stats_profile.update(stats_profile_params)
        render :show, status: :ok, location: api_stats_profile_url(@stats_profile)
      else
        render json: @stats_profile.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/stats_profiles/1
    def destroy
      @stats_profile.destroy
      head :no_content
    end

    # POST /api/stats_profiles/company
    def company
      symbol = stats_profile_company_params[:company][:symbol]
      name = stats_profile_company_params[:company][:name]
      year = stats_profile_company_params[:company][:year]

      stats = ExternalApi::Stock.get_monthly_prices({ symbol: symbol, start: year + "-01-01", end: year + "-12-01" })

      @stats_profile = StatsProfile.create(stats)
      @company = @stats_profile.companies.create({ name: name, symbol: symbol })
      @year = @stats_profile.years.update({ year: year, company_id: Company.last[:id], stats_profile_id: StatsProfile.last[:id] })

      if @stats_profile.save && @company.save
        render :all, status: :created, location: api_stats_profile_url(@stats_profile)
      else
        render json: @stats_profile.errors, status: :unprocessable_entity
      end
    end

    private
    def set_stats_profile
      @stats_profile = StatsProfile.find(params[:id])
    end

    def stats_profile_params
      params.require(:stats_profile).permit(:min, :max, :avg, :volatility, :annual_change)
    end

    def stats_profile_company_params
      params.require(:stats_profile).permit(:company => [ :symbol, :name, :year ])
    end
end
