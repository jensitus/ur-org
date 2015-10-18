Rails.application.routes.draw do

  get 'search/index'

  get 'notifications/index'
  get 'notifications/:id' => 'notifications#show', as: 'notification'
  get 'notifications/render_read'

  resources 'group_maintainers', only: [:create, :destroy]
  #get 'group_maintainers/create'
  #get 'group_maintainers/destroy'

  resources :groups

  resources 'group_memberships', only: [:create, :destroy]

  resources 'likes', only: [:create, :destroy]
  resources :comments

  resources :contacts

  get 'home' => 'static_pages#home'

  root 'static_pages#home'
  get 'about' => 'static_pages#about'

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
      get :sentbox
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

  resources :invites, only: [:new, :create]
  get 'invites/dele' => 'invites#dele', as: 'dele'

  resources :microposts
  get '/:slug/:id' => 'microposts#show', as: 'user_post'
  resources :relationships, only: [:create, :destroy]

  get '/:id' => 'users#show', as: 'single_user'

  resources :photos, only: :destroy

end
