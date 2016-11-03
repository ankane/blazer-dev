# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ENV["DEMO"] = ""

users = []
["Andrew", "Michael", "Nick", "Jen", "Stephanie", "Laura", "Tiffany", "Max", "Michelle", "Will", "Apoorva", "Nilam", "Maksim", "Heather", "DJ"].each do |name|
  users << User.where(name: name).first_or_create!
end

[
  {
    name: "Smart Variable",
    statement: "SELECT * FROM users WHERE occupation_id = {occupation_id}"
  },
  {
    name: "Smart Column",
    statement: "SELECT occupation_id, age, gender FROM users ORDER BY id LIMIT 100"
  },
  {
    name: "Linked Column",
    statement: "SELECT * FROM movies ORDER BY title LIMIT 100"
  },
  {
    name: "Line Chart Format 1",
    statement: "SELECT date_trunc('week', rated_at)::date AS week, COUNT(*) AS new_ratings FROM ratings GROUP BY week ORDER BY week"
  },
  {
    name: "Line Chart Format 2",
    statement: "SELECT\n  date_trunc('month', rated_at)::date AS month, gender, COUNT(*)\nFROM ratings INNER JOIN users ON ratings.user_id = users.id\nGROUP BY month, gender ORDER BY month, gender"
  },
  {
    name: "Column Chart Format 1",
    statement: "SELECT title,\nCOUNT(*) AS ratings_count,\nROUND(AVG(rating), 2) AS avg_rating\nFROM movies INNER JOIN ratings ON ratings.movie_id = movies.id\nGROUP BY movies.id HAVING COUNT(*) >= 10\nORDER BY avg_rating DESC\nLIMIT 50"
  },
  {
    name: "Column Chart Format 2",
    statement: "SELECT occupation_id, gender, COUNT(*) FROM ratings INNER JOIN users ON ratings.user_id = users.id GROUP BY 1, 2 ORDER BY 1, 2"
  },
  {
    name: "Target Line",
    statement: "SELECT date_trunc('week', rated_at)::date AS week,\nCOUNT(*) AS new_ratings, 5000 AS target\nFROM ratings GROUP BY week ORDER BY week"
  },
  {
    name: "Time Range Selector",
    statement: "SELECT * FROM ratings WHERE rated_at >= {start_time} AND rated_at <= {end_time}"
  },
  {
    name: "Check for Bad Data",
    statement: "SELECT * FROM users WHERE zip_code IS NULL"
  },
  {
    name: "Check for Missing Data",
    statement: "SELECT * FROM users WHERE zip_code IS NULL"
  },
  {
    name: "Check for Anomalies",
    statement: "SELECT date_trunc('week', rated_at)::date AS week, COUNT(*) AS new_ratings FROM ratings GROUP BY week ORDER BY week"
  },
  {
    name: "URLs",
    statement: "SELECT name, 'https://duckduckgo.com?q=' || name AS search_url FROM occupations"
  },
  {
    name: "Images",
    statement: "SELECT 'http://thecatapi.com/api/images/get?format=src&type=gif' AS image_url FROM ratings LIMIT 1"
  }
].each_with_index do |query, i|
  q = Blazer::Query.where(creator_id: users.shift).first_or_initialize
  q.assign_attributes(query)
  q.save(validate: false)
end

dashboard = Blazer::Dashboard.first_or_initialize
dashboard.creator = users.last
dashboard.update_attributes(name: "Dashboard Demo")
dashboard.dashboard_queries.destroy_all
[
  "Line Chart Format 1",
  "Line Chart Format 2",
  "Column Chart Format 1",
  "Column Chart Format 2",
  "Linked Column"
].each_with_index do |query_name, i|
  dashboard.dashboard_queries.create!(query_id: Blazer::Query.find_by(name: query_name).id, position: i)
end

Blazer::Check.destroy_all
Blazer::Check.create!(query_id: Blazer::Query.find_by(name: "Check for Bad Data").id, state: "passing", emails: "andrew@chartkick.com", check_type: "bad_data", schedule: "5 minutes")
Blazer::Check.create!(query_id: Blazer::Query.find_by(name: "Check for Missing Data").id, state: "failing", emails: "andrew@chartkick.com", check_type: "missing_data", schedule: "1 hour")
Blazer::Check.create!(query_id: Blazer::Query.find_by(name: "Check for Anomalies").id, state: "passing", emails: "andrew@chartkick.com", check_type: "anomaly", schedule: "1 day")
