Rails.application.routes.draw do
  devise_for :users
  get 'pages/index'
  get 'pages/show'
  get '/books/new', to: 'books#new'
  get '/books', to: 'books#index'
  resources :users
  resources :books, expect: [:index] do
    resources :reviews, only: [:create, :destroy]
  end
end
