Rails.application.routes.draw do
  mount Korgi::Engine => "/korgi"

  resources :posts
  resources :images
end
