Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  get 'sidebar' => 'mobile_nav#show_sidebar', as: 'sidebar'
  get 'stats' => 'mobile_nav#stats', as: 'stats'

  resources :email_notifications, only: [:create, :update, :delete]

  get 'notices/new'

  get 'notices/create'

#  if Rails.env.development?
  require 'sidekiq/web'
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
#  end

  resources :photo_galleries

  get 'search/index'

  get 'notifications/index'
  get 'notifications/render_read'
  get 'notifications/:id' => 'notifications#show' # , as: 'notification'

  resources 'group_maintainers', only: [:create, :destroy]

  resources :groups

  post 'groups/add_user_to_group'

  resources 'group_memberships', only: [:create, :destroy]

  resources 'likes', only: [:create, :destroy]
  resources :comments

  resources :contacts

  get 'home' => 'static_pages#home'

  # root 'static_pages#home'
  # root 'users#show'
  get 'about' => 'static_pages#about'

  get 'invitation_required' => 'static_pages#invitation_required'

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :invitations => 'users/invitations'
  }
  resource :custom_appearance, only: [:show, :update]
  post 'custom_appearances/change_color'
  post 'custom_appearances/blogroll'
  delete 'custom_appearances/delete_blog'
# root 'public#index'

  authenticated :user do
    # root 'users#index'
    # :root
    root 'static_pages#home'
  end

  unauthenticated :user do
    devise_scope :user do
      # get '/' => 'devise/sessions#new'
      # :root
      root 'static_pages#home'
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

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :invites, only: [:new, :create]
  get 'invites/dele' => 'invites#dele', as: 'dele'

  resources :microposts
  resources :photos, only: [:destroy, :show]
  get '/:slug/:id' => 'microposts#show', as: 'user_post'
  get 'new' => 'microposts#new_user_post', as: 'new_user_post'
  resources :relationships, only: [:create, :destroy]

  get '/:id' => 'users#show', as: 'single_user'

end
