Rails.application.routes.draw do

  get 'static_pages/home'

  get 'static_pages/help'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks'}
  # root 'public#index'

  authenticated :user do
    root 'users#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get '/' => 'devise/sessions#new'
    end
  end

  resources :conversations do
    resources :messages
  end

  resources :users
  resources :microposts

end
