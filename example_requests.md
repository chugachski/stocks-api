# Examples using cURL

## Companies
#### get a list the best matching symbols by company name
curl -v -H "Content-Type: application/json" -X GET -G http://warm-castle-30365.herokuapp.com/api/companies/symbols --data-urlencode 'name=home depot' | jq

#### get all companies
curl -v -H "Content-Type: application/json" -X GET -G http://warm-castle-30365.herokuapp.com/api/companies --data-urlencode page=1 --data-urlencode per_page=5 | jq

#### create a company and stats profile
curl -v -H "Content-Type: application/json" -X POST http://warm-castle-30365.herokuapp.com/api/companies -d '{"company": {"name": "The Home Depot Inc.", "symbol": "HD", "year": "2019"}}' | jq

#### delete a company
curl -v -H "Content-Type: application/json" -X DELETE http://warm-castle-30365.herokuapp.com/api/companies/5 | jq


## Stats Profiles
#### get all stats profiles
curl -v -H "Content-Type: application/json" -X GET -G http://warm-castle-30365.herokuapp.com/api/stats_profiles --data-urlencode page=1 --data-urlencode per_page=5 | jq

#### get stats profiles for all companies by year
curl -v -H "Content-Type: application/json" -X GET -G http://warm-castle-30365.herokuapp.com/api/stats_profiles --data-urlencode page=1 --data-urlencode per_page=5 --data-urlencode year=2018 --data-urlencode stat=volatility | jq

#### get stats profiles for all years by company
curl -v -H "Content-Type: application/json" -X GET -G http://warm-castle-30365.herokuapp.com/api/stats_profiles --data-urlencode page=1 --data-urlencode per_page=5 --data-urlencode symbol=HD --data-urlencode stat=annual_change | jq

### delete a stats profile
curl -v -H "Content-Type: application/json" -X DELETE http://warm-castle-30365.herokuapp.com/api/stats_profiles/5 | jq
