Rails.application.routes.draw do
  get "/users", to: "users#index"
  post "/users", to: "users#show"
  post "/create", to: "users#create"
end
