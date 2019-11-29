json.array!(@symbols) do |s|
  json.name s['2. name']
  json.symbol s['1. symbol']
end
