Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'pages/index'
  get 'pages/show'
  get '/books/new', to: 'books#new'
  get '/books', to: 'books#index'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :books, expect: [:index] do
    resources :reviews, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  post 'book_like/:id' => 'book_likes#create', as: 'create_book_like'
  delete 'book_like/:id' => 'book_likes#destroy', as: 'destroy_book_like'
end
