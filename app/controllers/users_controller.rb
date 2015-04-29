class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  before_action :require_admin, only: :index
  before_action :get_user
  before_action :follow

  def index
    @users = User.where.not('id = ?', current_user.id).order('created_at DESC')
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per(10)
    fresh_when :last_modified => @microposts.maximum(:updated_at)
  end

  def following
    @title = 'I am connected with:'
    @users = @user.following.page(params[:page]).per(5)
    render 'show_follow'
  end

  def followers
    @title = 'They connected me:'
    @users = @user.followers.page(params[:page]).per(5)
    render 'show_follow'
  end

  private

  def require_admin
    if !current_user.admin?
      flash[:danger] = 'NEIN!!'
      redirect_to request.referrer || root_url
    end
  end

  def get_user
    @user = User.friendly.find(params[:id])
  end

  def follow
    @followers = @user.followers.sample(3)
    @following = @user.following.sample(3)
  end

end