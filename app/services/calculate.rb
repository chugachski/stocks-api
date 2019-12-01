# based of of source: https://stackoverflow.com/a/21143604/12419324
module Calculate
  def self.calc_min(values = [])
    values.min
  end

  def self.calc_max(values = [])
    values.max
  end

  def self.calc_sum(values = [])
    values.inject(0){ |accum, i| accum + i }
  end

  def self.calc_avg(values = [])
    calc_sum(values) / values.length.to_f
  end

  def self.calc_annual_change(values = [])
    values.last - values.first / values.first * 100
  end

  def self.calc_sample_variance(values = [])
    m = calc_avg(values)
    sum = values.inject(0) { |accum, i| accum + (i - m) ** 2 }
    sum / (values.length - 1).to_f
  end

  def self.calc_volatility(values = [])
    Math.sqrt(calc_sample_variance(values))
  end
end
