# Blazer Dev

:fire: Dev app for [Blazer](https://github.com/ankane/blazer)

## Install

```sh
git clone https://github.com/ankane/blazer.git
git clone https://github.com/ankane/blazer-dev.git
cd blazer-dev
bundle
rails db:create db:migrate
```

Add MovieLens data if desired

```sh
createdb movielens
curl https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql | psql -d movielens
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
