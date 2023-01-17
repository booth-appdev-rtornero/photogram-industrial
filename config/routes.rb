Rails.application.routes.draw do
  root "photos#following"

  devise_for :users
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  get ":username/liked" => "photos#liked", as: :liked_photos

  get ":username/feed" => "photos#following", as: :following_photos

  get ":username/discover" => "photos#followingliked", as: :followingliked_photos

  get ":username/followers" => "users#followers", as: :followers_users
  
  get ":username/following" => "users#following", as: :following_users
  
  get ":username" => "users#show", as: :user
end
