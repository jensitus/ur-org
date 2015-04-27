class MicropostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :destroy, :update, :edit]
  before_action :correct_user, only: :destroy
  before_action :set_micropost, only: [:edit, :new, :update, :destroy, :show]

  respond_to :html, :js

  def new
    @micropost = Micropost.new
    respond_with(@micropost)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    mentions = Mention.get_the_mention(@micropost.content)
    if @micropost.save
      Mention.mention_it(mentions, @micropost)
      flash[:success] = '<b>jesus christ, you did it!!</b>'.html_safe
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @comment = Comment.new
    @micropost = Micropost.find(params[:id])
    #@likes = @micropost.likers(User)
    if !current_user.nil?
      @liked_by_current_user = @micropost.liked_by?(current_user)
    end
    @comments = @micropost.comments
    fresh_when etag: [@comments, @micropost, current_user]
  end

  def edit
    if current_user == @micropost.user
      @micropost = Micropost.find(params[:id])
    else
      flash[:alert] = "you don't have the permission to do that, we are dreadfully sorry "
      redirect_to request.referrer || root_url
    end
  end

  def update
    # respond_to do |format|
    if current_user == @micropost.user
      if @micropost.update(micropost_params)
        flash[:success] = 'yeah!!'
        redirect_to user_post_path :slug => @micropost.user.slug, :id => @micropost.id
        #flash[:success] = 'yeah!!'
        #redirect_to request.referrer || root_url
      else
        flash[:alert] = 'so nicht'
        render 'static_pages/home'
      end
    else
      flash[:alert] = "you don't have the permission to do that shit, sorry for that"
      redirect_to request.referrer || root_url
    end
    # end
  end

  def destroy
    if current_user == @micropost.user
    @micropost.destroy
      flash[:success] = "Oh no, it's deleted"
      redirect_to request.referrer || root_url
    else
      flash[:alert] = "you don't have the permission to do that shit, sorry for that"
      redirect_to request.referrer || root_url
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture, :group_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

end
