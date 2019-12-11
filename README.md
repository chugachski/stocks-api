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

Next, to create a stats profile with different annual price price statistics for PayPal, make a post request to `/api/companies` with a request body including parameters for `symbol`, `name` and `year`:
```
curl -v -H "Content-Type: application/json" -X POST http://localhost:3000/api/companies -d '{"company": {"symbol": "PYPL", "name": "PayPal Holdings Inc.", "year": "2016"}}'
```
The application will first create a record in the `companies` table if it doesn't already exist. Then it will fetch the monthly price data from the Tradier API, calculate statistics (min, max, average, ending, volatility and annual percent change), and create an entry in the `stats profiles` table.

But it's more interesting to compare the statistics. First, let's show annual change figures for all companies with 2018 statistics and order them from highest to lowest:
```
curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/stats_profiles --data-urlencode year=2018 --data-urlencode stat=annual_change --data-urlencode order=desc
```

We can also see a particular company's data over time. To show volatility for Home Depot for each year from low to high, run:
```
curl -v -H "Content-Type: application/json" -X GET -G http://localhost:3000/api/stats_profiles --data-urlencode symbol=HD --data-urlencode stat=annual_change
```

For all the possible endpoints and options, see the endpoint documentation below. If desired, view pagination data in the Link header.

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
| order_by     | string   | Optional  | id, name       | id        |
| order        | string   | Optional  | asc, desc      | asc       |
| page         | integer  | Optional  | 1, 2, 3, etc.  | 1         |
| per_page     | integer  | Optional  | 5, 10, 25, etc | 10        |

**Response:**
```
[
  {
    "id": 1,
    "name": "The Home Depot Inc.",
    "symbol": "HD"
  },
]
```

#### GET /api/companies/symbols
Get a list of best matching symbols

| Parameter    | Type     | Required  | Example value | Default   |
| ------------ | -------- | --------- | ------------- | --------- |
| name         | string   | Required  | home depot    | n/a       |

**Response:**
```
[
  {
    "name": "Hyatt Hotels Corporation",
    "symbol": "H"
  },
]
```

#### POST /api/companies
**Body Schema:**
```company:
  type: object
  properties:
    name:
      type: string
      example: The Home Depot Inc.
    symbol:
      type: string
      example: HD
    year:
      type: string
      example: 2016
```

**Response:**
```
{
  "id": 19,
  "name": "Hyatt Hotels Corporation",
  "symbol": "H"
}
```

#### DELETE /api/companies/:id




### Stats Profiles
#### GET /api/stats_profiles
| Parameter    | Type     | Required  | Values                          | Default   |
| ------------ | -------- | --------- | ------------------------------- | --------- |
| page         | integer  | Optional  | 1, 2, 3, etc.                   | 1         |
| per_page     | integer  | Optional  | 5, 10, 25, etc.                 | 10        |
| symbol       | string   | Optional  | AMZN, T, etc                    | n/a       |
| name         | string   | Optional  | Amazon.com Inc., AT&T Inc., etc | n/a       |
| year         | string   | Optional  | 2018, 2015, etc.                | n/a       |
| stat         | string   | Optional  | max, annual_change, etc.        | n/a       |

**Response:**
Without a stat included:
```
[
  {
    "id": 1,
    "company_id": 1,
    "year": "2018",
    "min": 171.82,
    "max": 207.15,
    "avg": 188.443333333333,
    "ending": 171.82,
    "volatility": 11.4534213493637,
    "annual_change": 71.82
  },
]
```

With a stat included:
```
[
  {
    "company": "Intel Corporation",
    "year": "2017",
    "volatility": 4.43634780176012
  },
]
```

#### DELETE /api/stats_profiles/:id
