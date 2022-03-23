Rails.application.routes.draw do
  get 'users/new'
  root 'home_pages#top'
  get  '/about',   to: 'home_pages#about'
  get  '/signup',  to: 'users#new'
  resources :users
end
