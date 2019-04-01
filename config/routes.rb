Rails.application.routes.draw do

  devise_for :users
  root 'groups#index'

  resources :groups do
  	resources :posts
  	post :join, on: :member
  	post :quit, on: :member
  end

  namespace :account do
  	resources :groups
  	resources :posts
  end

end
