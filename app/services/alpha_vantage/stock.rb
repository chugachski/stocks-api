module AlphaVantage

  class Stock
    KEY = ENV['ALPHA_VANTAGE_KEY']

    def self.search_by_symbol(query = {})
      puts "==> search by symbol"
      response = Request.where('query', {function: 'TIME_SERIES_DAILY', symbol: 'MSFT', apikey: KEY })
      puts "==> resp: #{response}"
      # stocks = response.fetch('stocks', []).map { |stock| Stock.new(stock) }
      # [ stocks, response[:errors] ]
    end
  end

end
