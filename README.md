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

## stats_profiles
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/stats_profiles
  - curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/stats_profiles --data-urlencode sort=asc
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/stats_profiles/11
- curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/stats_profiles/company -d '{"stats_profile": {"company": {"symbol": "KODK", "year": "2018"}}}'
- curl -v -H "Content-Type: application/json" -X DELETE http://localhost:3000/api/stats_profiles/9

## companies
- curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/companies/symbols --data-urlencode 'name=home depot'
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/companies
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/companies/8
- curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/companies -d '{"company": {"name": "The Home Depot Inc.", "symbol": "HD"}}'
- curl -v -H "Content-Type: application/json" -X DELETE http://localhost:3000/api/companies/3

## years
- curl -v -H "Content-Type: application/json" -X GET http://localhost:3000/api/years
- curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/years -d '{"year": {"year": "2018", "company_id": 8, "stats_profile_id": 9}}'
- curl -v -H "Content-Type: application/json" -X DELETE http://localhost:3000/api/years/3




Things you may want to cover:
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
