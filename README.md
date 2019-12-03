# Stocks API
**Request/response:** https://warm-castle-30365.herokuapp.com/api

### Contact
- Nate Smith
- natesmith.copper@gmail.com
- [linked in](https://www.linkedin.com/in/nathansmithcodes/)

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

### Running Tests (Rspec)
run `bundle exec rspec`

### Deploy to Heroku
`git push heroku master`

### Description
This API consumes data from the [Tradier API](https://documentation.tradier.com/index.html) and [Alpha Vantage API](https://www.alphavantage.co/documentation/) to allow users to view and compare historical price data for stocks they are interested in.

To get started, try making a GET request to `/api/companies/symbols?name=paypal` to get a list of the best matching symbols. Let's use curl:
```
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/companies/symbols --data-urlencode name=paypal
```

(You can use whatever tool to make requests you want. To view these requests in a nice format, I downloaded [jq](https://stedolan.github.io/jq/), and pipe into it.)

Next, to create a stats profile with different price annual price statistics for PayPal, make a post request to `/api/stats_profiles/create_all_resources` with a request body including the parameters you want:
```
curl -v -H "Content-Type: application/json" -X POST https://warm-castle-30365.herokuapp.com/api/stats_profiles/create_all_resources -d '{"stats_profile": {"company": {"symbol": "PYPL", "name": "PayPal Holdings Inc.", "year": "2018"}}}'
```
The application will first create a record in the `companies` table if it doesn't already exist. Then it will fetch the price monthly price data from the Tradier API, calculate statistics (min, max, average, ending, volatility and annual percent change), and create an entry in the `stats profiles table`.

But it's more interesting to compare the statistics. First, let's show annual change figures for all companies with 2018 statistics and order them from highest to lowest:
```
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/stats_profiles/all_companies_by_year --data-urlencode year=2018 --data-urlencode stat=annual_change --data-urlencode order=desc
```

We can also see a particular company's data over time. To show volatility for Home Depot for each year from low to high, run:
```
curl -v -H "Content-Type: application/json" -X GET -G https://warm-castle-30365.herokuapp.com/api/stats_profiles/all_years_by_company --data-urlencode symbol=HD --data-urlencode stat=volatility
```

For all the possible endpoints and options, see the endpoint documentation below.

Note: instead of a single `searches` table, this API has two tables named `companies` and `stats profiles`. Model validations ensure that posting the same data won't result in a duplicate entry.

### Endpoint Documentation
See examples of cURL requests in examples.md

#### For all requests
| Header       | Required | Value            |
| ------------ | -------- | ---------------- |
| Content-Type | Required | application/json |

### Companies
#### GET /api/companies
| Parameter    | Type     | Required  | Values         | Default   |
| ------------ | -------- | --------- | -------------- | --------- |
| order        | string   | Optional  | asc, desc      | asc       |
| page         | integer  | Optional  | 1, 2, 3, etc.  | 1         |
| per_page     | integer  | Optional  | 5, 10, 25, etc | 10        |

#### GET /api/companies/symbols
Get a list of best matching symbols

| Parameter    | Type     | Required  | Example value | Default   |
| ------------ | -------- | --------- | ------------- | --------- |
| name         | string   | Required  | home depot    | n/a       |

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




### Stats Profiles
#### GET /api/stats_profiles
| Parameter    | Type     | Required  | Values         | Default   |
| ------------ | -------- | --------- | -------------- | --------- |
| page         | integer  | Optional  | 1, 2, 3, etc.  | 1         |
| per_page     | integer  | Optional  | 5, 10, 25, etc | 10        |

#### GET /api/stats_profiles/all_companies_by_year
| Parameter    | Type     | Required  | Example values                                   | Default   |
| ------------ | -------- | --------- | ------------------------------------------------ | --------- |
| year         | string   | Required  | 2018                                             | n/a       |
| stat         | string   | Required  | min, max, avg, ending, volatility, annual_change | n/a       |
| order        | string   | Optional  | asc, desc                                        | asc       |
| page         | integer  | Optional  | 1, 2, 3, etc.                                    | 1         |
| per_page     | integer  | Optional  | 5, 10, 25, etc.                                  | 10        |

#### GET /api/stats_profiles/all_years_by_company
| Parameter    | Type     | Required  | Example values                                   | Default   |
| ------------ | -------- | --------- | ------------------------------------------------ | --------- |
| symbol       | string   | Required  | HD                                               | n/a       |
| stat         | string   | Required  | min, max, avg, ending, volatility, annual_change | n/a       |
| order        | string   | Optional  | asc, desc                                        | asc       |
| page         | integer  | Optional  | 1, 2, 3, etc.                                    | 1         |
| per_page     | integer  | Optional  | 5, 10, 25, etc.                                  | 10        |

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
