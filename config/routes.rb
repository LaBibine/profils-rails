Rails.application.routes.draw do
  get "/users", to: "users#index"
  post "/users/show", to: "users#show"
  get "/users/show", to: "users#show"
  post "/create", to: "users#create"
  get "/data", to: "users#data"
  post "/export", to: "users#export"
end
