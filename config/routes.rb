Rails.application.routes.draw do
 
  
  root to: 'blogs#index'
  resources :blogs
 
  resources :blogs, only: [:new, :create, :edit, :destroy]
  resources :sessions, only: [:new, :create, :edit, :destroy]
  resources :users
  
  resources :labels, only: [:create, :destroy]
  
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
