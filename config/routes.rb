Rails.application.routes.draw do

  resources :contacts

  get 'home' => 'static_pages#home'

  root 'static_pages#home'
  get 'static_pages/help'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks'}
  # root 'public#index'

  authenticated :user do
    # root 'users#index'
    :root
  end

  unauthenticated :user do
    devise_scope :user do
      # get '/' => 'devise/sessions#new'
      :root
    end
  end

  resources :conversations do
    resources :messages
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts
  get '/:slug/:id' => 'microposts#show', as: 'user_post'
  resources :relationships, only: [:create, :destroy]

  get '/:id' => 'users#show', as: 'single_user'

end
