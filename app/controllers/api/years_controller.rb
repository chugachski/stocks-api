class Api::YearsController < ApplicationController
    before_action :set_year, only: [:show, :update, :destroy]

    # GET /api/years
    def index
      @years = Year.all
    end

    # GET /api/years/1
    def show
    end

    # POST /api/years
    def create
      @year = Year.new(year_params)

      if @year.save
        render :show, status: :created
      else
        render json: @year.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/years/1
    def update
      if @year.update(year_params)
        render :show, status: :ok, location: api_year_url(@year)
      else
        render json: @year.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/years/1
    def destroy
      @year.destroy
      head :no_content
    end

    private
    def set_year
      @year = Year.find(params[:id])
    end

    def year_params
      params.require(:year).permit(:year, :company_id, :stats_profile_id)
    end
end
