Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  root   'home_pages#top'
  get    '/about',   to: 'home_pages#about'
  get    '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[new create edit destroy update]
  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
