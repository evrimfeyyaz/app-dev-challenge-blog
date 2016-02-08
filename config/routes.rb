Rails.application.routes.draw do
  root to: "posts#index"

  get  'contact', to: 'messages#new'
  resources :posts, path: '', only: [:index, :show]
  resources :categories, only: [:show]
  resources :messages, only: [:create]

  namespace :admin do
    root to: "posts#index"
    get 'login', to: 'sessions#new'
    get 'logout', to: 'sessions#destroy'
    resource :sessions, only: [:create, :destroy]
    resources :posts, except: [:show] do
      collection do
        delete :destroy_multiple
      end
    end
    resources :categories, except: [:show] do
      collection do
        delete :destroy_multiple
      end
    end
    resources :images do
      collection do
        delete :destroy_multiple
      end
    end
  end
end
