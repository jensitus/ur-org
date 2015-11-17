class StaticPagesController < ApplicationController

  respond_to :js

  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      ########
      @photo = @micropost.photos.build
      ########
      @placeholder = 'Compose your message to the world ...'
      @feed_items = current_user.feed.page(params[:page]).per(8)
      @likes = @micropost.likers(User)
      @liked_by_current_user = @micropost.liked_by?(current_user)
      @following = current_user.following.sample(3)
      @followers = current_user.followers.sample(3)
      fresh_when :etag => [@feed_items, current_user]
    else
      if Rails.env.development?
        @static_page_image = Photo.find(60).picture
      elsif Rails.env.production?
        @static_page_image = Photo.find(35).picture
      end
      #@static_page_image = Micropost.where('picture IS NOT NULL').sample(1)[0].picture
      # @static_page_image = Photo.all.sample(1)[0].picture
      @microposts = Micropost.where('picture IS NULL AND group_id IS NULL').sample(3)
      render :layout => 'not_signed_in'
    end

  end

  def about
  end

end
