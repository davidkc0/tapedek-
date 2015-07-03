Rails.application.routes.draw do
devise_for :users, :path => '', :path_names => {:sign_in => 'im_ron_antill ', :sign_out => 'sign out', :sign_up => "north_remebers69"}
  get 'static_pages/home'
  get 'about', to: 'static_pages#about'
  resources :posts do
    member do
      put "like" , to: "posts#upvote"
      put "dislike" , to: "posts#downvote"
    end
  end
  root 'posts#index'
end
