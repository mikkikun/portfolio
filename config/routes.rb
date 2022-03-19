Rails.application.routes.draw do
  root 'home_pages#top'
  get  '/about',   to: 'home_pages#about'
end
