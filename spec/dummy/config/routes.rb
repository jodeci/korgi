Rails.application.routes.draw do
  mount Korgi::Engine => "/korgi"

  namespace :admin do
    resources :posts
  end

  resources :posts
end
