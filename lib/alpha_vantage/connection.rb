require 'faraday'
require 'json'

class Connection
  BASE = 'https://www.alphavantage.co'

  def self.api
   Faraday.new(url: BASE) do |faraday|
     faraday.response :logger do |logger|
       logger.filter(/(apikey=)(\w+)/,'\1[REMOVED]')
     end
     faraday.adapter Faraday.default_adapter
     faraday.headers['Content-Type'] = 'application/json'
   end
  end
end
