Rails.application.routes.draw do

  root "home#index"

  get "my_articles", to: "my_articles#index", as: :my_articles

  resources :posts

  devise_for :users

  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

end