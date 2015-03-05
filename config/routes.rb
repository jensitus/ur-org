Rails.application.routes.draw do

  resources :comments

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


  get '/messages' => redirect('/conversations')
  resources :messages do
    member do
      post :new
    end
  end

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
    collection do
      get :trashbin
      post :empty_trash
    end
  end

  #get 'conversations/index' => 'conversations#index', as: 'conversations'
  #get 'conversations/reply_form' => 'conversations#reply_form', :as => 'reply_form'
  #get 'conversations/:id' => 'conversations#show', as: 'conversation'
  #put 'conversations/:id' => 'conversations#reply'
  #get 'conversations/new_release' => 'conversations#new_release', as: 'new_release'

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
