Rails.application.routes.draw do
  devise_for :users

  match '/auth/:provider/callback', to: 'authentications#create', via: [:get, :post]
  
  get '/home', to: 'static_pages#home', as: :home
  get '/about', to: 'static_pages#about', as: :about
  get '/random', to: 'posts#random', as: :random
  post '/report', to: 'reports#create', as: :report
  get '/admin', to: 'static_pages#admin', as: :admin

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
  resources :users, only: [:show]
  resources :tags, only: [:show]
  
  root 'posts#index'
end
