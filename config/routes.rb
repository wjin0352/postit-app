PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # get 'posts', to: "posts#index"
  # get 'posts/:id', to: "posts#show"
  # get 'posts/new', to: "posts#new"
  # post 'posts', to: "posts#create"
  # get 'posts/:id/edit', to: "posts#edit"
  # patch 'posts/:id', to: "posts#update"

  resources :posts, except: [:destroy] do
    member do
      post 'vote'
    end
    resources :comments, only: [:create, :vote] do
      member do
        post 'vote'
      end
    end
  end

  resources :users, except: [:index]
  resources :categories, only: [:new, :create, :show]
end
