require 'faraday'

class Api::StocksController < ApplicationController

  def index
    puts "==> index method"
    @stocks = AlphaVantage::Stock.search_by_symbol(query)
  end

  private
  def query
    params.fetch(:query, {})
  end
end
