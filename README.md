# Blazer Dev

:fire: Dev app for [Blazer](https://github.com/ankane/blazer)

## Install

```sh
git clone https://github.com/ankane/blazer.git
git clone https://github.com/ankane/blazer-dev.git
cd blazer-dev
bundle
rails db:create
rails db:schema:load
```

If desired, [add MovieLens data](https://github.com/ankane/movielens.sql) and run:

```sh
echo "BLAZER_DATABASE_URL=postgres://localhost/movielens" >> .env
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
