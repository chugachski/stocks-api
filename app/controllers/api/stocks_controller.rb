require 'faraday'

class Api::StocksController < ApplicationController
  include Calculate

  def prices
    @prices = AlphaVantage::Stock.get_monthly_prices({ symbol: params[:symbol] })
    # find_min()
  end

  def symbols
    @symbols = AlphaVantage::Stock.find_symbols({ keywords: params[:name] })
  end

  private
  def query
    params.fetch(:query, {})
  end
end
