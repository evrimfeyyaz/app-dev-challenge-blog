Rails.application.routes.draw do
  root to: "posts#index"
  resources :posts, only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    resources :posts, except: [:show]
    get 'login', to: 'sessions#new'
    get 'logout', to: 'sessions#destroy'
    resource :sessions, only: [:create, :destroy]
  end
end
