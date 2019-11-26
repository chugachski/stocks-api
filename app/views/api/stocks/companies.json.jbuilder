puts "==> @companies: #{@companies}"
json.array!(@companies) do |c|
  json.description c['description']
  json.symbol c['symbol']
end
