require 'date'

module ExternalApi
  class Stock
    extend Calculate

    def self.lookup_companies(query = {})
      response = Request.where('alpha_vantage', 'query', query.merge({ function: 'SYMBOL_SEARCH', apikey: ENV['ALPHA_VANTAGE_KEY'] }))
      companies = response.fetch('bestMatches')
    end

    def self.get_monthly_prices(query = {})
      response = Request.where('tradier', 'markets/history', query.merge({ interval: 'monthly', start: '2016-01-01', end: '2018-12-01' }))

      price_history = Hash.new { |h, k| h[k]=[] }
      response.fetch('history')['day'].each do |month|
        year = month['date'][0..3]
        price_history[year] << month['close']
      end
      # puts "==> price_history: #{price_history}"

      stats_by_year = []
      price_history.each do |year, prices|
        stats = Hash.new { |h, k| h[k]=[] }
        stats[year] << {min: calc_min(prices)}
        stats[year] << {max: calc_max(prices)}
        stats[year] << {avg: calc_avg(prices)}
        stats[year] << {volatility: calc_volatility(prices)}
        stats[year] << {annual_change: calc_annual_change(prices)}
        # puts "==> stats: #{stats}"
        stats_by_year.push(stats)
      end

      # stats_profiles = stats_by_year.map do |year|
      #   stats_profile = year.map { |y, attrs| Stock.new(attrs) }
      # end
      # puts "==> stats profiles: #{stats_profiles}"

      stats_by_year
    end
  end
end
