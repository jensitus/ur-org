class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  around_filter :catch_not_found
  before_action :require_admin, only: :index

  def index
    @users = User.where.not('id = ?', current_user.id).order('created_at DESC')
    #@conversations = Conversation.involving(current_user).order('created_at DESC')
  end

  def show
    @user = User.friendly.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(10)
    fresh_when :last_modified => @microposts.maximum(:updated_at)
  end

  def following
    @title = 'I am connected with:'
    @user = User.friendly.find(params[:id])
    @users = @user.following.page(params[:page]).per(5)
    render 'show_follow'
  end

  def followers
    @title = 'They connected me:'
    @user = User.friendly.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render 'show_follow'
  end

  private

  def catch_not_found
    yield
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'gibt es nicht'
      redirect_to root_url
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = 'NEIN!!'
      redirect_to request.referrer || root_url
    end

  end

end