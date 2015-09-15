Rails.application.routes.draw do
  devise_for :users

  match '/auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
  
  get '/home', to: 'static_pages#home', as: :home
  get '/about', to: 'static_pages#about', as: :about
  get '/random', to: 'posts#random', as: :random

  resources :posts do
    member do
      put "like" , to: "posts#upvote"
      put "dislike" , to: "posts#downvote"
      get "comments" , to: "comments#show"
    end
  end

  resources :comments
  
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end

  resources :messages, only: [:new, :create]
  
  
  root 'posts#index'
end
