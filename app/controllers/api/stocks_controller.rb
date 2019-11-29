require 'faraday'

class Api::StocksController < ApplicationController
  # GET /api/companies
  def symbols
    @symbols = ExternalApi::Stock.lookup_companies({ keywords: params[:name] })
  end

  # POST /api/stats
  def stats
    stats_by_year = ExternalApi::Stock.get_monthly_prices({ symbol: params[:symbol] }) # array of hashes that are indexed by year
    puts "==> stats by year: #{stats_by_year}"

    binding.pry
    @stats_profile = StatsProfile.new(stats_by_year[0]['2016'])
    # puts "@stats profile: #{@stats_profile}"
  end

  private
  def query
    params.fetch(:query, {})
  end
end
