class Api::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  after_action only: [:index] do
    set_pagination_headers :companies
  end

  # GET /api/companies/symbols?name=coke
  def symbols
    @symbols = ExternalApi::Stock.lookup_symbols({ keywords: params[:name] })
  end

  # GET /api/companies
  def index
    @companies = Company.page(page).per(per_page)
    @companies = @companies.send("set_order", order_by, direction)
  end

  # POST /api/companies
  def create
    symbol = company_params[:symbol]
    name = company_params[:name]
    year = company_params[:year]

    stats = ExternalApi::Stock.get_monthly_prices({ symbol: symbol, start: year + "-01-01", end: year + "-12-01" })

    @company = Company.find_or_create_by({ name: name, symbol: symbol })
    @stats_profile = @company.stats_profiles.create(stats.merge({ year: year }))

    if @stats_profile.save
      render :show, status: :created, location: api_stats_profile_url(@company)
    else
      render json: @stats_profile.errors, status: :unprocessable_entity
    end
  end

  # POST /api/companies/refresh
  def refresh
  end

  # DELETE /api/companies/1
  def destroy
    @company.destroy
    head :no_content
  end

  private
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :symbol, :year)
  end

  def direction
    direction = params[:order] || :asc
  end

  def order_by
    order_by = params[:order_by] || :id
  end

  def page
    page = params[:page] || 1
  end

  def per_page
    per_page = params[:per_page] || 10
  end
end
