require 'date'

module AlphaVantage
  class Stock
    KEY = ENV['ALPHA_VANTAGE_KEY']

    def self.get_monthly_prices(query = {})
      response = Request.where('markets/history', query.merge({ interval: 'monthly', start: '2016-01-01', end: '2018-12-01' }))
      history = response.fetch('history')['day']
      data = Hash.new { |h, k| h[k]=[] }

      history.each do |month|
        year = month['date'][0..3]
        data[year] << month['close']
      end

      data
    end

    def self.lookup_companies(query = {})
      response = Request.where('markets/lookup', query.merge({ types: 'stock' }))
      companies = response.fetch('securities')['security']
    end
  end
end
