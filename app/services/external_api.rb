module ExternalApi
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
         logger.filter(/(apikey=)(\w+)/,'\1[REMOVED]')
       end
       faraday.adapter Faraday.default_adapter
       faraday.headers['Accept'] = 'application/json'
       faraday.headers['Content-Type'] = 'application/json'
     end
    end
  end

  # adapted from source: https://revs.runtime-revolution.com/integrating-a-third-party-api-with-rails-5-134f960ddbba
  class Request
    def self.where(source, resource_path, query = {})
      response, status = get_json(source, resource_path, query)
      status == 200 ? response : errors(response)
    end

    def self.get_json(source, root_path, query = {})
      query_string = query.map{|k, v| "#{k}=#{v}"}.join("&")
      path = query.empty?? root_path : "#{root_path}?#{query_string}"
      response = api(source).get(path)
      [JSON.parse(response.body), response.status]
    end

    def self.errors(response)
      error = { errors: { status: response["status"], message: response["message"] } }
      response.merge(error)
    end

    def self.api(source)
      if source == "alpha_vantage"
        Connection.alpha_vantage
      else
        Connection.tradier
      end
    end
  end

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
        stats[:min] = Calculate.min(prices)
        stats[:max] = Calculate.max(prices)
        stats[:avg] = Calculate.avg(prices)
        stats[:ending] = Calculate.ending(prices)
        stats[:volatility] = Calculate.volatility(prices)
        stats[:annual_change] = Calculate.annual_change(prices)
      end

      stats
    end
  end
end
