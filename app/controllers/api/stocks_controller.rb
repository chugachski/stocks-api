require 'faraday'

class Api::StocksController < ApplicationController
  include Calculate

  def prices
    prices = AlphaVantage::Stock.get_monthly_prices({ symbol: params[:symbol] })
    min_2018 = calc_min(prices['2018'])
    max_2018 = calc_max(prices['2018'])
    avg_2018 = calc_avg(prices['2018'])
    volatility_2018 = calc_volatility(prices['2018'])
    annual_change_2018 = calc_annual_percent_change(prices['2018'])
  end

  def companies
    @companies = AlphaVantage::Stock.lookup_companies({ q: params[:name] })
  end

  private
  def query
    params.fetch(:query, {})
  end
end
