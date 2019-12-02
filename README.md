# Stocks API

## Dependencies
- Rails version: 2.6.5
- Ruby version: 6.0.1
- postgresql: 10.10

## Getting Started with local development
1. create `.env` at project root containing:
  - ALPHA_VANTAGE_KEY="example_key"
  - TRADIER_KEY="example_key"
  - STOCKS_API_DATABASE_PASSWORD="example_key"
2. bundle install
3. rake db:create
  - [set up](https://stackoverflow.com/a/23127354/12419324) the `stocks_api` database user
  - in case of error: `FATAL: Peer authentication failed for user`, edit `pg_hba.conf` such that the method for local connections is `md5`
4. rake db:migrate


## Stats Profiles
### get all stats profiles
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/stats_profiles
  - curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/stats_profiles --data-urlencode sort=asc

### get stats profiles for all companies by year
- curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/stats_profiles/all_companies_by_year --data-urlencode year=2017 --data-urlencode stat=volatility --data-urlencode order=asc

### get stats profiles for all years by company
- curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/stats_profiles/all_years_by_company --data-urlencode symbol=HD --data-urlencode stat=annual_change --data-urlencode order=desc

### get a stats profile
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/stats_profiles/11

### create a stats profile
- curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/stats_profiles -d '{"stats_profile": {"company_id": 1, "year": "2014", "min": 34.54, "max": 39.90, "avg": 37.84, "ending": 36.64, "volatility": 1.65, "annual_change": 5.3}}'

- curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/stats_profiles/create_all_resources -d '{"stats_profile": {"company": {"symbol": "KODK", "name": "Eastman Kodak Company", "year": "2018"}}}'

### delete a stats profile
- curl -v -H "Content-Type: application/json" -X DELETE http://localhost:3000/api/stats_profiles/9


## Companies
### find symbols by company name
- curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/companies/symbols --data-urlencode 'name=home depot'

### get all companies
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/companies
- curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/companies --data-urlencode 'order=desc'

### get a company
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/companies/8

### create a company
- curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/companies -d '{"company": {"name": "The Home Depot Inc.", "symbol": "HD"}}'

### delete a company
- curl -v -H "Content-Type: application/json" -X DELETE http://localhost:3000/api/companies/3




Things you may want to cover:
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
