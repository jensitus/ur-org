Rails.application.routes.draw do

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

end
