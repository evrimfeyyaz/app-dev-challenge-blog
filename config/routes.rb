Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :categories, only: [:show]
end
