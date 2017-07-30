Rails.application.routes.draw do

  get "search", to: "search#index", as: :searchs
  get "/search/:q", to: "search#show", as: :search

  resources :known_topics, only: [:create, :update, :destroy]
  resources :topics, only: [:index, :show, :create]
  resources :themes, only: :create
  root to: "static#home"

  devise_for :users
  resources :users

  get "/help", to: "static#help", as: :help

end
