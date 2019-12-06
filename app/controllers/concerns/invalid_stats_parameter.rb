class InvalidStatsParameter < StandardError
  def http_status
    422
  end

  def code
    "bad stats parameter"
  end

  def message
    "Request does not pass an acceptable stats parameter (required)"
  end

  def stats
    ["min", "max", "avg", "ending", "volatility", "annual_change"]
  end
end
