# Stocks API
http://example.com

### Dependencies
- Rails version: 2.6.5
- Ruby version: 6.0.1
- postgresql: 10.10

### Getting Started with local development
1. create `.env` at project root containing:
  - ALPHA_VANTAGE_KEY="example_key"
  - TRADIER_KEY="example_key"
  - STOCKS_API_DATABASE_PASSWORD="example_key"
2. bundle install
3. rake db:create
  - [set up](https://stackoverflow.com/a/23127354/12419324) the `stocks_api` database user
  - in case of error: `FATAL: Peer authentication failed for user`, edit `pg_hba.conf` such that the method for local connections is `md5`
4. rake db:migrate

### Endpoint Documentation
See examples of cURL requests in examples.md

#### For all requests
| Header       | Required | Value            |
| ------------ | -------- | ---------------- |
| Content-Type | Required | application/json |

### Companies
#### GET /api/companies
| Parameter    | Type     | Required  | Values      | Default   |
| ------------ | -------- | --------- | ----------- | --------- |
| order        | string   | Optional  | asc, desc   | asc       |

#### GET /api/stats_profiles/all_companies_by_year
| Parameter    | Type     | Required  | Example values                                   | Default   |
| ------------ | -------- | --------- | ------------------------------------------------ | --------- |
| year         | string   | Required  | 2018                                             | n/a       |
| stat         | string   | Required  | min, max, avg, ending, volatility, annual_change | n/a       |
| order        | string   | Optional  | asc, desc                                        | asc       |

#### GET /api/stats_profiles/all_years_by_company
| Parameter    | Type     | Required  | Example values                                   | Default   |
| ------------ | -------- | --------- | ------------------------------------------------ | --------- |
| symbol       | string   | Required  | HD                                               | n/a       |
| stat         | string   | Required  | min, max, avg, ending, volatility, annual_change | n/a       |
| order        | string   | Optional  | asc, desc                                        | asc       |

#### GET /api/companies/:id

#### POST /api/companies
Body Schema:
```company:
  type: object
  properties:
    name:
      type: string
      example: The Home Depot Inc.
    symbol:
      type: string
      example: HD
```

#### UPDATE /api/companies/:id
Body Schema: see POST

#### DELETE /api/companies/:id

#### GET /api/companies/symbols
Get a list of best matching symbols

| Parameter    | Type     | Required  | Example value | Default   |
| ------------ | -------- | --------- | ------------- | --------- |
| name         | string   | Required  | home depot    | n/a       |


### Stats Profiles
#### GET /api/stats_profiles

#### GET /api/stats_profiles/:id

#### POST /api/stats_profiles
Create a stats profile directly
Body Schema:
```stats_profile:
  type: object
  properties:
    company_id:
      type: integer
      example: 1
    year:
      type: string
      example: 2018
    min:
      type: float
      example: 34.60
    max:
      type: float
      example: 38.86
    avg:
      type: float
      example: 35.98
    ending:
      type: float
      example 37.55
    volatility:
      type: float
      example: 1.35
    annual_change:
      type: float
      example: 3.5
```

#### POST /api/stats_profiles/create_all_resources
Create a stats profile with a company name, symbol and year
```stats_profile:
  type: object
  properties:
    symbol:
      type: integer
      example: MDLZ
    name:
      type: string
      example: Mondelez International Inc.
    year:
      type: string
      example: 2018
```

#### UPDATE /api/stats_profiles/:id
Body Schema: see POST

#### DELETE /api/stats_profiles/:id


Things you may want to cover:
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
