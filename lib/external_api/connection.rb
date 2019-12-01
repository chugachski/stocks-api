require 'faraday'
require 'json'

class Connection
  TRADIER_BASE = 'https://sandbox.tradier.com/v1'
  ALPHA_VANTAGE_BASE = 'https://www.alphavantage.co'
  TRADIER_KEY = ENV['TRADIER_KEY']

  def self.tradier
   Faraday.new(url: TRADIER_BASE) do |faraday|
     faraday.response :logger
     faraday.adapter Faraday.default_adapter
     faraday.headers['Accept'] = 'application/json'
     faraday.headers['Authorization'] = "Bearer #{TRADIER_KEY}"
   end
  end

  def self.alpha_vantage
   Faraday.new(url: ALPHA_VANTAGE_BASE) do |faraday|
     faraday.response :logger do |logger|
       logger.filter(/(apikey=)(\w+)/,'\1[REMOVED]'))
     faraday.adapter Faraday.default_adapter
     faraday.headers['Accept'] = 'application/json'
     faraday.headers['Content-Type'] = 'application/json'
   end
  end
end
