json.array!(@stats_profiles) do |sp|
  json.company sp.company[:name]
  json.year sp[:year]

  case @stat
  when :min
    json.min sp[:min]
  when :max
    json.max sp[:max]
  when :avg
    json.avg sp[:avg]
  when :ending
    json.avg sp[:ending]
  when :volatility
    json.volatility sp[:volatility]
  when :annual_change
    json.annual_change sp[:annual_change]
  end
end
