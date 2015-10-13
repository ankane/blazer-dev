# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ENV["DEMO"] = ""

users = []
["Andrew", "Michael", "Nick", "Jen", "Stephanie", "Laura", "Tiffany", "Max", "Michelle", "Will", "Apoorva", "Nilam"].each do |name|
  users << User.where(name: name).first_or_create!
end

[
  {
    name: "New Ratings Per Week",
    statement: "SELECT date_trunc('week', rated_at)::date AS week, COUNT(*) AS new_ratings FROM ratings GROUP BY week ORDER BY week"
  },
  {
    name: "Top Genres",
    statement: "SELECT\n  genres.name, COUNT(*) AS movies_count\nFROM genres_movies INNER JOIN genres ON genres_movies.genre_id = genres.id\nGROUP BY genres.name ORDER BY movies_count DESC"
  },
  {
    name: "Users By Occupation",
    statement: "SELECT * FROM users WHERE occupation_id = {occupation_id}"
  },
  {
    name: "Highest Rated Movies",
    statement: "SELECT title, COUNT(*) AS ratings_count, ROUND(AVG(rating), 2) AS avg_rating\nFROM movies INNER JOIN ratings ON ratings.movie_id = movies.id\nGROUP BY movies.id HAVING COUNT(*) >= 10\nORDER BY avg_rating DESC\nLIMIT 50"
  },
  {
    name: "Movies By Genre",
    statement: "SELECT movies.* FROM movies INNER JOIN genres_movies ON genres_movies.movie_id = movies.id WHERE genre_id = {genre_id}"
  },
  {
    name: "Cumulative Ratings",
    statement: "SELECT\n  date_trunc('week', rated_at)::date AS week,\n  sum(count(id)) OVER (ORDER BY date_trunc('week', rated_at)::date) AS ratings_count\nFROM ratings\nGROUP BY week",
  },
  {
    name: "New Ratings By Gender Per Month",
    statement: "SELECT\n  date_trunc('month', rated_at)::date AS month, gender, COUNT(*)\nFROM ratings INNER JOIN users ON ratings.user_id = users.id\nGROUP BY month, gender ORDER BY month, gender"
  },
  {
    name: "Ratings By Time Range",
    statement: "SELECT * FROM ratings WHERE rated_at >= {start_time} AND rated_at <= {end_time}"
  },
  {
    name: "Users Without Zip Code",
    statement: "SELECT * FROM users WHERE zip_code IS NULL"
  },
  {
    name: "Users",
    statement: "SELECT * FROM users LIMIT 100"
  }
].each_with_index do |query, i|
  q = Blazer::Query.where(creator_id: users.shift).first_or_initialize(id: i + 1)
  q.assign_attributes(query)
  q.save(validate: false)
end

dashboard = Blazer::Dashboard.first_or_initialize
dashboard.update_attributes(name: "Ratings")
dashboard.dashboard_queries.destroy_all
[
  "New Ratings Per Week",
  "New Ratings By Gender Per Month",
  "Highest Rated Movies"
].each_with_index do |query_name, i|
  dashboard.dashboard_queries.create!(query_id: Blazer::Query.find_by(name: query_name).id, position: i)
end

Blazer::Check.destroy_all
Blazer::Check.create!(query_id: Blazer::Query.find_by(name: "Users Without Zip Code").id, state: "passing", emails: "andrew@hero2app.com")
