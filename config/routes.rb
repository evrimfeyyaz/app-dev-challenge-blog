Rails.application.routes.draw do
  root to: "posts#index"

  get  'feed', to: 'posts#index', defaults: { format: :atom }
  get  'contact', to: 'messages#new'
  post 'contact', to: 'messages#create'
  resources :posts, path: '', only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    root to: "posts#index"
    get     'login', to: 'sessions#new'
    post    'login', to: 'sessions#create'
    delete  'logout', to: 'sessions#destroy'
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
