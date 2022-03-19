Rails.application.routes.draw do
  root 'home_pages#home'
  get 'home_pages/top'
  get 'home_pages/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
