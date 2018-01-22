class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :new_user_post, :destroy, :update, :edit]
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
    puts 'micropost_params'
    puts micropost_params[:group_id]
    @micropost = current_user.microposts.build(micropost_params)
    mentions = Mention.get_the_mention(@micropost.content)
    if @micropost.save
      if params[:photos].nil?
        puts 'no photo'
      else
        params[:photos]['picture'].each do |p|
          @photo = @micropost.photos.create!(:picture => p, :micropost_id => @micropost.id, :user_id => @micropost.user_id)
        end
      end
      if !micropost_params[:group_id].nil?
        group_id = micropost_params[:group_id]
        # GroupChatJob.perform_later(@micropost)
        ActionCable.server.broadcast "group_#{@micropost.group_id}_channel", message: render_posting(@micropost)
        respond_to do |format|
          format.js
        end
      else
        Mention.mention_it(mentions, @micropost)
        flash[:success] = '<b>jesus christ, you did it!!</b>'.html_safe
        redirect_to root_url
      end
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
    if user_signed_in?
      @email_notification = EmailNotification.find_by(micropost_id: @micropost.id, user_id: current_user.id)
    end
    if @email_notification.nil?
      @email_notification = EmailNotification.new
    end
    #fresh_when etag: [@comments, @micropost, current_user]
    respond_with [micropost: @micropost, comment: @comments]
  end

  def edit
    if current_user == @micropost.user
      @micropost = Micropost.find(params[:id])
      @photo = @micropost.photos.build
      @galleries = current_user.photo_galleries
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
            @photo = @micropost.photos.create!(:picture => p, :micropost_id => @micropost.id, :user_id => current_user.id)
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

  def render_posting(posting)
    puts '-----------------------------------------'
    puts posting.inspect
    puts '_________________________________________'
    GroupsController.render partial: 'microposts/micropost', locals: {micropost: posting}
  end

end
