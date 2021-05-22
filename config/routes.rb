Rails.application.routes.draw do
  devise_for :users
  get 'pages/index'
  get 'pages/show'
  get '/posts', to: 'books#new'
  resources :users
  resources :books
end
