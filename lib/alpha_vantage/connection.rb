require 'faraday'
require 'json'

class Connection
  # curl -X GET "https://sandbox.tradier.com/v1/markets/history?interval=monthly&start=2019-01-01&end=2019-10-10&symbol=AA" -H 'Authorization: Bearer GyuiYMLUu7TdUBLmS0XGaE2WyXYG' -H 'Accept: application/json'
  BASE = 'https://sandbox.tradier.com/v1'

  def self.api
   Faraday.new(url: BASE) do |faraday|
     faraday.response :logger
     faraday.adapter Faraday.default_adapter
     faraday.headers['Accept'] = 'application/json'
     faraday.headers['Authorization'] = 'Bearer GyuiYMLUu7TdUBLmS0XGaE2WyXYG'
   end
  end
end
