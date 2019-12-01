json.array!(@stats_profiles) do |sp|
  json.year @year
  json.annual_change sp[:annual_change]
  json.company_name sp.companies.first[:name]
end
