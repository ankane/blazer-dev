# Blazer Dev

Dev app for Blazer

## Install

```sh
git clone https://github.com/ankane/blazer.git
git clone https://github.com/ankane/blazer-dev.git
cd blazer-dev
bundle
bin/rake db:create db:migrate
```

Add MovieLens data if desired

```sh
createdb movielens
curl https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql | psql -d movielens
echo 'BLAZER_DATABASE_URL=postgres://localhost/movielens' >> .env
rake db:seed
```

Otherwise, create `.env` with:

```
BLAZER_DATABASE_URL=postgres://localhost/yourdb
```

## Run

```sh
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000) and start developing.

Thanks for helping to make Blazer better for everyone!
