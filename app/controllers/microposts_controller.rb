class MicropostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :destroy, :update, :edit]
  before_action :correct_user, only: :destroy
  before_action :set_micropost, only: [:edit, :new, :update, :destroy, :show]
  before_action :follow, only: :show

  def new
    #@micropost = Micropost.new
    @photo = @micropost.photos.build
    # respond_with(@micropost)
  end

  def new_user_post
    @micropost = Micropost.new
    @photo = @micropost.photos.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    mentions = Mention.get_the_mention(@micropost.content)
    if @micropost.save
      if params[:photos].nil?
        puts '#################################'
        puts 'yessssss'
        puts '#################################'
      else
        params[:photos]['picture'].each do |p|
          @photo = @micropost.photos.create!(:picture => p, :micropost_id => @micropost.id)
        end
      end
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
    @photos = @micropost.photos.all
    if !current_user.nil?
      @liked_by_current_user = @micropost.liked_by?(current_user)
    end
    @comments = @micropost.comments.order(:id)
    #fresh_when etag: [@comments, @micropost, current_user]
    respond_with [micropost: @micropost, comment: @comments]
  end

  def edit
    if current_user == @micropost.user
      @micropost = Micropost.find(params[:id])
      @photo = @micropost.photos.build
    else
      flash[:alert] = "you don't have the permission to do that, we are dreadfully sorry "
      redirect_to request.referrer || root_url
    end
  end

  def update
    # respond_to do |format|
    if current_user == @micropost.user
      if @micropost.update(micropost_params)
        if params[:photos].nil?
          puts '#################################'
          puts 'yessssss the fucking edit'
          puts '#################################'
        else
          params[:photos]['picture'].each do |p|
            @photo = @micropost.photos.create!(:picture => p, :micropost_id => @micropost.id)
          end
        end
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
    params.require(:micropost).permit(:content, :group_id, photos_attributes: [:id, :micropost_id, :picture])
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  def follow
    @followers = @micropost.user.followers.sample(3)
    @following = @micropost.user.following.sample(3)
  end

end
