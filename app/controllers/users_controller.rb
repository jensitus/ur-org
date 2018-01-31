class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :require_admin, only: :index
  before_action :get_user
  before_action :follow
  # before_action :photo_galleries, except: :index
  # before_action :latest_photo_comments, except: :index

  def index
    @users = User.where.not('id = ?', current_user.id).order('created_at DESC')
  end

  def show
    @microposts = @user.microposts.where(group_id: nil).page(params[:page]).per(10)
    fresh_when :last_modified => @microposts.maximum(:updated_at)
  end

  def following
    @title = 'I am connected with:'
    @users = @user.following.page(params[:page]).per(15)
    render 'show_follow'
  end

  def followers
    @title = 'They connected me:'
    @users = @user.followers.page(params[:page]).per(15)
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

  # def photo_galleries
  #   @galleries = @user.photo_galleries
  # end

  # def latest_photo_comments
  #   @latest_photo_comments = @user.latest_photo_comments.limit(10)
  # end

end