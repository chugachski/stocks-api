class Api::StatsProfilesController < ApplicationController
    before_action :set_stats_profile, only: [:show, :update, :destroy]

    # GET /api/stats_profiles
    def index
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

    # POST /api/stats_profiles/create_all_resources
    def create_all_resources
      symbol = stats_profile_all_resources_params[:company][:symbol]
      name = stats_profile_all_resources_params[:company][:name]
      year = stats_profile_all_resources_params[:company][:year]

      stats = ExternalApi::Stock.get_monthly_prices({ symbol: symbol, start: year + "-01-01", end: year + "-12-01" })

      @company = Company.find_or_create_by({ name: name, symbol: symbol })
      @stats_profile = StatsProfile.create(stats.merge({ company_id: @company[:id], year: year }))

      if @stats_profile.save
        render :all_resources, status: :created, location: api_stats_profile_url(@stats_profile)
      else
        render json: @stats_profile.errors, status: :unprocessable_entity
      end
    end

    def all_companies_by_year
      year = params["year"] # required
      @stat = params["stat"].to_sym # required
      order = params["order"].nil? ? :asc : params["order"].to_sym # optional, defaults to asc order

      case @stat
      when :volatility
        @stats_profiles = StatsProfile.by_year(year).by_volatility(order)
      when :annual_change
        @stats_profiles = StatsProfile.by_year(year).by_annual_change(order)
      when :min
        @stats_profiles = StatsProfile.by_year(year).by_min(order)
      when :max
        @stats_profiles = StatsProfile.by_year(year).by_max(order)
      when :avg
        @stats_profiles = StatsProfile.by_year(year).by_avg(order)
      when :ending
        @stats_profiles = StatsProfile.by_year(year).by_ending(order)
      else
        @stats_profiles = StatsProfile.all
      end

      render :all_companies_by_year, status: :ok
    end

    def all_years_by_company
      symbol = params["symbol"].to_sym # required
      @stat = params["stat"].to_sym # required
      order = params["order"].nil? ? :asc : params["order"].to_sym # optional
      company_id = Company.find_by(symbol: symbol)[:id]

      case @stat
      when :volatility
        @stats_profiles = StatsProfile.by_company(company_id).by_volatility(order)
      when :annual_change
        @stats_profiles = StatsProfile.by_company(company_id).by_annual_change(order)
      when :min
        @stats_profiles = StatsProfile.by_company(company_id).by_min(order)
      when :max
        @stats_profiles = StatsProfile.by_company(company_id).by_max(order)
      when :avg
        @stats_profiles = StatsProfile.by_company(company_id).by_avg(order)
      when :ending
        @stats_profiles = StatsProfile.by_company(company_id).by_ending(order)
      else
        @stats_profiles = StatsProfile.all
      end

      render :all_years_by_company, status: :ok
    end

    private
    def set_stats_profile
      @stats_profile = StatsProfile.find(params[:id])
    end

    def stats_profile_params
      params.require(:stats_profile).permit(:company_id, :year, :min, :max, :avg, :ending, :volatility, :annual_change)
    end

    def stats_profile_all_resources_params
      params.require(:stats_profile).permit(:company => [ :symbol, :name, :year ])
    end
end
