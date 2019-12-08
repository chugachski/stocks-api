class Api::StatsProfilesController < ApplicationController
    before_action :set_stats_profile, only: [:show, :update, :destroy]

    ALLOWED_STATS = [:min, :max, :avg, :ending, :volatility, :annual_change].freeze

    after_action only: [:index, :all_companies_by_year, :all_years_by_company] do
      set_pagination_headers :stats_profiles
    end

    # GET /api/stats_profiles
    def index
      @stats_profiles = StatsProfile.page(page).per(per_page)
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
      @stats_profile = @company.stats_profiles.create(stats.merge({ year: year }))

      if @stats_profile.save
        render :all_resources, status: :created, location: api_stats_profile_url(@stats_profile)
      else
        render json: @stats_profile.errors, status: :unprocessable_entity
      end
    end

    def all_companies_by_year
      year = params["year"]
      @stat = params["stat"].to_sym

      @stats_profiles = StatsProfile.by_year(year).page(page).per(per_page)

      if ALLOWED_STATS.include?(@stat)
        @stats_profiles = @stats_profiles.send("by_#{@stat}", order)
      else
        raise InvalidStatsParameter
      end

      render :all_companies_by_year, status: :ok
    end

    def all_years_by_company
      company = Company.find_by(symbol: symbol)
      raise NoCompanyExists if company.nil?
      symbol = params["symbol"].to_sym
      @stat = params["stat"].to_sym

      @stats_profiles = StatsProfile.by_company(company[:id]).page(page).per(per_page)

      if ALLOWED_STATS.include?(@stat)
        @stats_profiles = @stats_profiles.send("by_#{@stat}", order)
      else
        raise InvalidStatsParameter
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

    def order
      order = params[:order] || 'asc'
    end

    def order_by
      order_by = params[:order_by] || 'id'
    end

    def stat
      stat = params[:stat]
    end

    def page
      page = params[:page] || 1
    end

    def per_page
      per_page = params[:per_page] || 10
    end
end
