class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      @placeholder = 'Compose your message to the world ...'
      @feed_items = current_user.feed.page(params[:page]).per(5)
      @likes = @micropost.likers(User)
      @liked_by_current_user = @micropost.liked_by?(current_user)
      @following = current_user.following.sample(3)
      @followers = current_user.followers.sample(3)
      fresh_when :etag => [@feed_items, current_user]
    else
      @static_page_image = Micropost.where('picture IS NOT NULL').sample(1)[0].picture.url
      @microposts = Micropost.where('picture IS NULL AND group_id IS NULL').sample(3)
    end
  end

  def about
  end
end
