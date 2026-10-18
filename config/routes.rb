
Rails.application.routes.draw do
  root "home#index"

  get "my_articles", to: "my_articles#index", as: :my_articles

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
    resources :likes, only: [ :create, :destroy ]
  end

  devise_for :users

  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "preferences/categories",
      to: "application#edit_categories",
      as: :edit_user_categories

  patch "preferences/categories",
        to: "application#update_categories",
        as: :update_user_categories

  namespace :api do
    namespace :v1 do
      post "login", to: "sessions#create"
      delete "logout", to: "sessions#destroy"
      get "me", to: "sessions#show"

      resources :posts, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
end
