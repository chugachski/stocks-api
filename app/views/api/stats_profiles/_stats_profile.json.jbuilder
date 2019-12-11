json.company stats_profile.company[:name]
json.year stats_profile[:year]

if @display_stat.nil?
  json.extract! stats_profile, :id, :company_id, :year, :min, :max, :avg, :ending, :volatility, :annual_change
else
  json.extract! stats_profile, :id, @display_stat.to_sym
end
