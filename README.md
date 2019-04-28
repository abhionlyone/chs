## How to Run this App?

### Dependencies

Make sure you have bundler, then install the dependencies:

```shell
$ gem install bundler
$ bundle install
```

### Database
* Copy database.yml and if you need, setup your own database credentials
* Create database (you must use MySQL)
* Run migrations

```shell
$ cp config/database.sample.yml config/database.yml
$ bin/rake db:create
$ bin/rake db:seed
```

### Install Redis

This app requires Redis for background processing and caching.

**Homebrew**

If you're on OS X, Homebrew is the simplest way to install Redis:

```shell
$ brew install redis
$ redis-server
```

You now have Redis running on 6379.

## List of available APIs

POST a reading
```shell
POST /readings
```
Get a reading
```shell
GET /readings/:id
```

Get Stats for a thermostat
```shell
GET /readings/:thermostat_id/stats
```

## Run Tests

```shell
$ bundle exec rspec
```