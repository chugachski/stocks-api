# Examples using cURL

## Companies
#### get a list the best matching symbols by company name
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/companies/symbols --data-urlencode 'name=home depot'

#### get all companies
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/companies --data-urlencode order=asc --data-urlencode page=1 --data-urlencode per_page=5

#### get a company
curl -v -H "Content-Type: application/json" -X GET https://warm-castle-30365.herokuapp.com/api/companies/5

#### create a company
curl -v -H "Content-Type: application/json" -X POST https://warm-castle-30365.herokuapp.com/api/companies -d '{"company": {"name": "The Home Depot Inc.", "symbol": "HD"}}'

#### update a company
curl -v -H "Content-Type: application/json" -X PUT http://localhost:3000/api/companies/1 -d '{"company": {"name": "The Home Depot Incorporated"}}'

#### delete a company
curl -v -H "Content-Type: application/json" -X DELETE https://warm-castle-30365.herokuapp.com/api/companies/5


## Stats Profiles
#### get all stats profiles
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/stats_profiles --data-urlencode page=1 --data-urlencode per_page=5

#### get stats profiles for all companies by year
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/stats_profiles/all_companies_by_year --data-urlencode year=2017 --data-urlencode stat=volatility --data-urlencode order=asc --data-urlencode page=1 --data-urlencode per_page=5

#### get stats profiles for all years by company
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/stats_profiles/all_years_by_company --data-urlencode symbol=HD --data-urlencode stat=annual_change --data-urlencode order=desc --data-urlencode page=1 --data-urlencode per_page=5

#### get a stats profile
curl -v -H "Content-Type: application/json" -X GET https://warm-castle-30365.herokuapp.com/api/stats_profiles/5

#### create a stats profile
curl -v -H "Content-Type: application/json" -X POST https://warm-castle-30365.herokuapp.com/api/stats_profiles -d '{"stats_profile": {"company_id": 1, "year": "2014", "min": 34.54, "max": 39.90, "avg": 37.84, "ending": 36.64, "volatility": 1.65, "annual_change": 5.3}}'

#### create a stats profile and a company if it doesn't already exist
curl -v -H "Content-Type: application/json" -X POST https://warm-castle-30365.herokuapp.com/api/stats_profiles/create_all_resources -d '{"stats_profile": {"company": {"symbol": "MDLZ", "name": "Mondelez International Inc.", "year": "2016"}}}'

#### update a stats profile
curl -v -H "Content-Type: application/json" -X PUT http://localhost:3000/api/stats_profiles/27 -d '{"stats_profile": {"annual_change": 10}}'

### delete a stats profile
curl -v -H "Content-Type: application/json" -X DELETE https://warm-castle-30365.herokuapp.com/api/stats_profiles/5
