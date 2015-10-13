Rails.application.routes.draw do
  if ENV["REDIRECT"]
    get "*path", to: redirect("http://blazer.hero2app.com/%{path}")
    root to: redirect("http://blazer.hero2app.com")
  end
  mount Blazer::Engine, at: "/"
end
