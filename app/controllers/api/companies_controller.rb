class Api::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  after_action only: [:index] do
    set_pagination_headers :companies
  end

  # GET /api/companies
  def index
    @companies = Company.order(name: direction).page(page).per(per_page)
  end

  # GET /api/companies/1
  def show
  end

  # POST /api/companies
  def create
    @company = Company.new(company_params)

    if @company.save
      render :show, status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/companies/1
  def update
    if @company.update(company_params)
      render :show, status: :ok, location: api_company_url(@company)
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/companies/1
  def destroy
    @company.destroy
    head :no_content
  end

  # GET /api/companies/symbols?name=coke
  def symbols
    @symbols = ExternalApi::Stock.lookup_symbols({ keywords: params[:name] })
  end

  private
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :symbol)
  end

  def direction
    direction = params[:order] || :asc
  end

  def page
    page = params[:page] || 1
  end

  def per_page
    per_page = params[:per_page] || 10
  end
end
