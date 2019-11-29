require 'faraday'

class Api::StocksController < ApplicationController
  # GET /api/companies
  def symbols
    @symbols = ExternalApi::Stock.lookup_companies({ keywords: params[:name] })
  end

  # POST /api/stats
  def stats
    stats_by_year = ExternalApi::Stock.get_monthly_prices({ symbol: params[:symbol] })

    stats_profiles = {}
    stats_by_year.each do |year, stats|
      stats_profile = StatsProfile.new(stats)
      stats_profiles[year] = stats_profile
    end
    binding.pry

    stats_profiles
  end

  private
  def query
    params.fetch(:query, {})
  end
end
