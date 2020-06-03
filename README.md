# Blazer Dev

:fire: Dev app for [Blazer](https://github.com/ankane/blazer)

## Install

```sh
git clone https://github.com/ankane/blazer.git
git clone https://github.com/ankane/blazer-dev.git
cd blazer-dev
bundle
rails db:create db:schema:load
```

Add MovieLens data if desired

```sh
ruby generate.rb path/to/ml-100k > movielens.sql
createdb movielens
psql -d movielens < movielens.sql
echo 'BLAZER_DATABASE_URL=postgres://localhost/movielens' >> .env
rails db:seed
```

Otherwise, create `.env` with:

```
BLAZER_DATABASE_URL=postgres://localhost/yourdb
```

## Run

```sh
rails server
```

Open [http://localhost:3000](http://localhost:3000) and start developing.

Thanks for helping to make Blazer better for everyone!
