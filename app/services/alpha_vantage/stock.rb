require 'date'

module AlphaVantage
  class Stock
    KEY = ENV['ALPHA_VANTAGE_KEY']

    def self.get_monthly_prices(query = {})
      response = Request.where('query', query.merge({ function: 'TIME_SERIES_MONTHLY', apikey: KEY }))
      prices = Hash[response.fetch('Monthly Time Series').to_a[0, 12]]
      # puts "==> prices: #{prices}"

      # data = {}
      # months = prices.each do |k, v|
      #   year = k[0..3]
      #   closing = '4. close'
      #
      #   if year == '2018'
      #     data['2018'] = v[closing]
      #   elsif year == '2017'
      #     data['2017'] = v[closing]
      #   elseif year == '2016'
      #     data['2016'] = v[closing]
      #   end
      # end
      # puts "==> data: #{data}"

    end

    def self.find_symbols(query = {})
      response = Request.where('query', query.merge({ function: 'SYMBOL_SEARCH', apikey: KEY }))
      symbols = response.fetch('bestMatches')
    end
  end
end
