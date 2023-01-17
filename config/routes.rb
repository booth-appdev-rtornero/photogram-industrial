Rails.application.routes.draw do
  root "photos#index"

  devise_for :users
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  get ":username/liked" => "photos#liked", as: :liked_photos

  get ":username/feed" => "photos#following", as: :photos_following

  get ":username/followers" => "users#followers", as: :followers_users
  
  get ":username/following" => "users#following", as: :following_users

  get ":username" => "users#show", as: :user
end
