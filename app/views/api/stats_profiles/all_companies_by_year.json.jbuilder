binding.pry
json.array!(@stats_profiles) do |sp|
  json.company_name sp.companies.first[:name]
  json.the_year sp.years.first.year

  case @stat
  when :volatility
    json.volatility sp[:volatility]
  when :annual_change
    json.annual_change sp[:annual_change]
  when :min
    json.min sp[:min]
  when :max
    json.max sp[:max]
  when :avg
    json.avg sp[:avg]
  end
end
