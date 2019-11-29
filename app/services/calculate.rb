require 'descriptive_statistics'

module Calculate
  extend ActiveSupport::Concern

  def calc_min(values = [])
    values.min
  end

  def calc_max(values = [])
    values.max
  end

  def calc_avg(values = [])
    values.inject(0.0) { |sum, el| sum + el } / values.size
  end

  def calc_volatility(values = [])
    values.standard_deviation
  end

  def calc_annual_change(values = [])
    values.last - values.first / values.first * 100
  end
end
