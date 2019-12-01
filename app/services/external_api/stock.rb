require 'date'

module ExternalApi
  class Stock
    def self.lookup_symbols(query = {})
      response = Request.where('alpha_vantage', 'query', query.merge({ function: 'SYMBOL_SEARCH', apikey: ENV['ALPHA_VANTAGE_KEY'] }))
      companies = response.fetch('bestMatches')
    end

    def self.get_monthly_prices(query = {})
      response = Request.where('tradier', 'markets/history', query.merge({ interval: 'monthly' }))

      price_history = Hash.new { |h, k| h[k]=[] }
      response.fetch('history')['day'].each do |month|
        year = month['date'][0..3]
        price_history[year] << month['close']
      end

      stats = {}
      price_history.each do |year, prices|
        stats[:min] = Calculate.calc_min(prices)
        stats[:max] = Calculate.calc_max(prices)
        stats[:avg] = Calculate.calc_avg(prices)
        stats[:volatility] = Calculate.calc_volatility(prices)
        stats[:annual_change] = Calculate.calc_annual_change(prices)
      end

      stats
    end
  end
end
