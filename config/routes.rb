Rails.application.routes.draw do
  root to: "posts#index"
  resources :posts, only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    get 'login', to: 'sessions#new'
    get 'logout', to: 'sessions#destroy'
    resource :sessions, only: [:create, :destroy]
    resources :posts, except: [:show]
    resources :categories, except: [:show]
    resources :images
  end
end
