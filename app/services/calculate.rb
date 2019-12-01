# based of of source: https://stackoverflow.com/a/21143604/12419324
module Calculate
  def self.min(values = [])
    values.min
  end

  def self.max(values = [])
    values.max
  end

  def self.ending(values = [])
    values.last
  end

  def self.sum(values = [])
    values.inject(0){ |accum, i| accum + i }
  end

  def self.avg(values = [])
    sum(values) / values.length.to_f
  end

  def self.annual_change(values = [])
    values.last - values.first / values.first * 100
  end

  def self.sample_variance(values = [])
    m = avg(values)
    sum = values.inject(0) { |accum, i| accum + (i - m) ** 2 }
    sum / (values.length - 1).to_f
  end

  def self.volatility(values = [])
    Math.sqrt(sample_variance(values))
  end
end
