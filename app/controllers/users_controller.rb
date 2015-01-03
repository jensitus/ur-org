class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  around_filter :catch_not_found

  def index
    @users = User.where.not('id = ?', current_user.id).order('created_at DESC')
    @conversations = Conversation.involving(current_user).order('created_at DESC')
  end

  def show
    @user = User.friendly.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 5 )
  end

  def following
    @title = 'I am connected with:'
    @user = User.friendly.find(params[:id])
    @users = @user.following.paginate(page: params[:page], :per_page => 5 )
    render 'show_follow'
  end

  def followers
    @title = 'They connected me:'
    @user = User.friendly.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def catch_not_found
    yield
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'gibt es nicht'
      redirect_to root_url
  end


end