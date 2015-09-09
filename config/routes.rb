Rails.application.routes.draw do
  devise_for :users
  
  get '/home', to: 'static_pages#home', as: :home
  get '/about', to: 'static_pages#about', as: :about
  get '/random', to: 'posts#random', as: :random

  resources :posts do
    member do
      put "like" , to: "posts#upvote"
      put "dislike" , to: "posts#downvote"
    end
  end
  
  root 'posts#index'
end
